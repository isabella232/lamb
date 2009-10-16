Given /^everything is enabled$/ do
  Given "the broker is enabled"
  Given "all workers are enabled"
end

Given /^all workers are enabled$/ do
  Given "the start worker is enabled"
  Given "the check worker is enabled"
  Given "the finish worker is enabled"
end

Given /^the broker is enabled$/ do
  # noop
end

Given /^the start worker is enabled$/ do
  Lamb.enable_start
end

Given /^the check worker is enabled$/ do
  Lamb.enable_check
end

Given /^the finish worker is enabled$/ do
  Lamb.enable_finish
end

When /^(\d+) jobs? (?:is|are) added$/ do |jobs|
  jobs.times do
    Lamb.add :provisioner, @instances.push(Instance.new).last
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
