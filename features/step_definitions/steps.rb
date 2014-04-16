Before do
  @system = Finitio::TEST_SYSTEM
end

Given(/^the System is$/) do |source|
  @system = Finitio::DEFAULT_SYSTEM.parse(source)
end

Given(/^the System source is$/) do |src|
  @system_source = src
end

Given(/^the type under test is (.*?)$/) do |typename|
  @type_under_test = @system[typename]
end
