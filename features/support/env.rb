require "#{File.dirname __FILE__}/../../lamb"
require "#{File.dirname __FILE__}/fixtures"

Before do
  Lamb.reset
  Store.reset

  Lamb.register :my_work do |job|
    job.start {|worker| worker.start ; worker }
    job.check {|worker| worker.check ; worker }
    job.finish do |worker|
      worker.finish
      Store.push worker
    end
  end
end

Transform /^\d+$/ do |num|
  num.to_i
end
