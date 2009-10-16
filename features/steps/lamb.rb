Given /^the broker is started$/ do
  # noop
end

Given /^the workers are started$/ do
  Lamb.process
end

When /^(\d+) jobs? (?:is|are) scheduled$/ do |jobs|
  jobs.times do
    Lamb.schedule :provisioner, @instances.push(Instance.new).last
  end
end

When /^I take a nap$/ do
  sleep 0.1
end

Then /^start has been called (\d+) times?$/ do |times|
  @instances.inject(0) {|sum, i| sum + i.provisions }.should == times
end

Then /^check has been called (\d+) times?$/ do |times|
  @instances.inject(0) {|sum, i| sum + i.checks }.should == times
end

Then /^finish has been called (\d+) times?$/ do |times|
  @instances.inject(0) {|sum, i| sum + i.finishes }.should == times
end
