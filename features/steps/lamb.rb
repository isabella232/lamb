Given /^the broker is started$/ do
  # noop
end

When /^(\d+) jobs? (?:is|are) scheduled$/ do |j|
  j.times do
    Lamb.schedule :provisioner, @instances.push(Instance.new).last
  end
end

When /^(\d+) jobs? (?:is|are) scheduled with (\d+)\/(\d+)\/(\d+) start\/check\/finish exceptions$/ do |j, s, c, f|
  j.times do
    Lamb.schedule :provisioner, @instances.push(Instance.new s, c, f).last
  end
end

Given /^the workers are started$/ do
  Lamb.process
end

When /^I take a nap$/ do
  sleep 0.1
end

Then /^start\/check\/finish has been called (\d+)\/(\d+)\/(\d+) times?$/ do |s, c, f|
  Then "start has been called #{s} times"
  Then "check has been called #{c} times"
  Then "finish has been called #{f} times"
end

Then /^start has been called (\d+) times?$/ do |times|
  @instances.inject(0) {|sum, i| sum + i.starts }.should == times
end

Then /^check has been called (\d+) times?$/ do |times|
  @instances.inject(0) {|sum, i| sum + i.checks }.should == times
end

Then /^finish has been called (\d+) times?$/ do |times|
  @instances.inject(0) {|sum, i| sum + i.finishes }.should == times
end
