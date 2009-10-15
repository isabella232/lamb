Before do
  @queues = {}
  @jobs = {}
end

Transform /^(\d+)$/ do |num|
  num.to_i
end

Transform /^queue "(.*)"$/ do |name|
  @queues[name]
end

Transform /^jobs "(.*)"$/ do |name|
  @jobs[name]
end

Given /^a new queue "(.*)"$/ do |name|
  @queues[name] = Lamb::Queue.new
end

Given /^a new job "(.*)"$/ do |name|
  @jobs[name] = Lamb::Job.new
end

When /^(job ".*") is added to (queue ".*")$/ do |job, queue|
  queue.add job
end

When /^(queue ".*") is processed$/ do |queue|
  queue.process
end

Then /^(queue ".*") should have (\d+) jobs$/ do |queue, size|
  queue.size.should == size
end
