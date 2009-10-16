module Lamb
  def self.reset
    @@workers = {}
    @@jobs = {}
  end
  reset

  def self.register name, &block
    @@jobs[name] = {:start => [], :check => [], :finish => []}
    worker = Worker.new
    worker.instance_eval &block
    @@workers[name] = worker
  end

  def self.add name, job
    @@jobs[name][:start].push job
  end

  def self.process
    @@jobs.each do |name, jobs|
      while job = jobs[:start].pop
        next_job = @@workers[name].work :start, job
        jobs[:check].push next_job
      end

      while job = jobs[:check].pop
        next_job = @@workers[name].work :check, job
        jobs[:finish].push next_job
      end

      while job = jobs[:finish].pop
        @@workers[name].work :finish, job
      end
    end
  end

  class Worker
    def initialize
      @start = @check = @finish = lambda{|arg| }
    end

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
