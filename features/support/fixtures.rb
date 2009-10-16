class Instance
  attr_reader :starts, :checks, :finishes, :exceptions
  def initialize
    @starts = @checks = @finishes = 0
    @exceptions = {:start => 0, :check => 0, :finish => 0}
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
