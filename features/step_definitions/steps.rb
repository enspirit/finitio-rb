require 'ostruct'
require 'path'

Before do
  @system = Finitio::TEST_SYSTEM
end

Given(/^the System is(, within '(.*?)')?$/) do |path,source|
  if path
    begin
      target = Path.dir.parent/path
      target.write(source)
      @system = Finitio.system(target)
    rescue => ex
      @system = ex
    end
  else
    @system = Finitio::TEST_SYSTEM.parse(source)
  end
end

Given(/^the type under test is (.*?)$/) do |typename|
  @type_under_test = @system[typename]
end
