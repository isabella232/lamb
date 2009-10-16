class Instance
  attr_reader :results
  attr_reader :provisions, :checks, :finishes
  def initialize exceptions={}
    @provisions = @checks = @finishes = 0
    @exceptions = {:provision => 0, :check => 0, :finish => 0}
    exceptions.each{|k,v| @exceptions[k] = v }
    @results = []
  end

  def provision
    @provisions += 1
    until @exceptions[:provision] == 0
      @exceptions[:provision] -= 1
      raise Exception.new
    end
  end

  def status
    @checks += 1
    until @exceptions[:check] == 0
      @exceptions[:check] -= 1
      raise Exception.new
    end
  end

  def finish
    @finishes += 1
    until @exceptions[:finish] == 0
      @exceptions[:finish] -= 1
      raise Exception.new
    end
  end
end
