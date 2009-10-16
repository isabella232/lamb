require "#{File.dirname __FILE__}/../../lamb"
require "#{File.dirname __FILE__}/fixtures"

Before do
  Lamb.register :provisioner do |job|
    job.start {|instance| instance.start ; instance }
    job.check {|instance| instance.check ; instance }
    job.finish {|instance| instance.finish }
  end
  @instances = []
end

After do
  Lamb.reset
end

Transform /^\d+$/ do |num|
  num.to_i
end
