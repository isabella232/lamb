require "thread"

module Lamb
  def self.reset
    @@workers = {}
    @@jobs = {}
  end
  reset

  def self.register name, &block
    @@jobs[name] = {
      :start => Queue.new,
      :check => Queue.new,
      :finish => Queue.new
    }
    worker = Worker.new
    worker.instance_eval &block
    @@workers[name] = worker
  end

  def self.schedule name, job
    @@jobs[name][:start].push job
  end

  def self.process
    @@jobs.each do |name, jobs|
      Thread.new do
        loop do
          job = jobs[:start].pop
          begin
            next_job = @@workers[name].work :start, job
            jobs[:check].push next_job
          rescue Exception
            jobs[:start].push job
          end
        end
      end

      Thread.new do
        loop do
          job = jobs[:check].pop
          begin
            next_job = @@workers[name].work :check, job
            jobs[:finish].push next_job
          rescue Exception
            jobs[:check].push job
          end
        end
      end

      Thread.new do
        loop do
          job = jobs[:finish].pop
          begin
            @@workers[name].work :finish, job
          rescue Exception
            jobs[:finish].push job
          end
        end
      end
    end
  end

  class Worker
    def work context, job
      instance_variable_get("@#{context}").call job
    end

    def start &block
      @start = block
    end

    def check &block
      @check = block
    end

    def finish &block
      @finish = block
    end
  end
end
