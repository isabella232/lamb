require "#{File.dirname __FILE__}/../lamb"

Spec::Runner.configure do |config|
  config.after do
    Lamb.reset
  end
end

