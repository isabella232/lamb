require "redis"

class Store
  @@redis = Redis.new

  def self.push val
    @@redis.push_tail "store", Marshal.dump(val)
  end

  def self.values
    @@redis.list_range("store", 0, -1).map do |val|
      Marshal.load val
    end
  end

  def self.reset
    @@redis.delete "store"
  end
end

class ExampleWorker
  attr_reader :starts, :checks, :finishes, :exceptions
  def initialize s=0, c=0, f=0
    @starts = @checks = @finishes = 0
    @exceptions = {:start => s, :check => c, :finish => f}
  end

  def start
    @starts += 1
    unless @exceptions[:start] == 0
      @exceptions[:start] -= 1
      raise Exception.new
    end
  end

  def check
    @checks += 1
    unless @exceptions[:check] == 0
      @exceptions[:check] -= 1
      raise Exception.new
    end
  end

  def finish
    @finishes += 1
    unless @exceptions[:finish] == 0
      @exceptions[:finish] -= 1
      raise Exception.new
    end
  end
end
