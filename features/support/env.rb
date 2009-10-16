require "#{File.dirname __FILE__}/../../lamb"
require "#{File.dirname __FILE__}/fixtures"

Before do
  Lamb.reset
  Store.reset

  Lamb.register :provisioner do |job|
    job.start {|instance| instance.start ; instance }
    job.check {|instance| instance.check ; instance }
    job.finish do |instance|
      instance.finish
      Store.push instance
    end
  end
end

Transform /^\d+$/ do |num|
  num.to_i
end
