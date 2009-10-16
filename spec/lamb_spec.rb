require "#{File.dirname __FILE__}/spec_helper"

MockException = Class.new Exception

Instance = Class.new do
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
      raise MockException
    end
  end

  def status
    @checks += 1
    until @exceptions[:check] == 0
      @exceptions[:check] -= 1
      raise MockException
    end
  end

  def finish
    @finishes += 1
    until @exceptions[:finish] == 0
      @exceptions[:finish] -= 1
      raise MockException
    end
  end
end

describe "Jobs without exceptions" do
  before do
    Lamb.register :provisioner do |job|
      job.start {|instance| instance.provision ; instance }
      job.check {|instance| instance.status ; instance }
      job.finish {|instance| instance.finish }
    end
    Lamb.add :provisioner, @instance = Instance.new
    Lamb.process
  end

  it "are started 1 time" do
    @instance.provisions == 1
  end

  it "are checked 1 time" do
    @instance.checks.should == 1
  end

    it "are finished 1 time" do
    @instance.finishes.should == 1
  end
end

describe "Jobs with 5 provision exceptions, 2 check exceptions, and 9 finish exceptions" do
  before do
    Lamb.register :provisioner do |job|
      job.start {|instance| instance.provision ; instance }
      job.check {|instance| instance.status ; instance }
      job.finish {|instance| instance.finish }
    end
    Lamb.add :provisioner, @instance = Instance.new(:provision => 5, :check => 2, :finish => 9)
    Lamb.process
  end

  it "are started 6 times" do
    @instance.provisions == 6
  end

  it "are checked 3 times" do
    @instance.checks.should == 3
  end

    it "are finished 10 times" do
    @instance.finishes.should == 10
  end
end
