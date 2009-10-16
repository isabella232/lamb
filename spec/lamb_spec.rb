require "#{File.dirname __FILE__}/spec_helper"

MockException = Class.new Exception

Instance = Class.new do
  attr_reader :results
  attr_reader :provisions, :checks, :finishes
  def initialize
    @provisions = @checks = @finishes = 0
    @results = []
  end

  def provision
    @provisions += 1
  end

  def status
    @checks += 1
  end

  def finish
    @finishes += 1
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
