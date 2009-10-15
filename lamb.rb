module Lamb
  class Queue
    def initialize
      @jobs = []
    end

    def add job
      @jobs.push job
    end

    def process
      while @jobs.pop
      end
    end

    def size
      @jobs.size
    end
  end

  class Job
  end
end
