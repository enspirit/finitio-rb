### dressing

Given(/^I dress JSON's '(.*?)'$/) do |str|
  @type_under_test ||= @system.main
  doc = MultiJson.load(str)
  @result = @type_under_test.dress(doc) rescue $!
end

Given(/^I dress JSON's '(.*?)' with (.*?)$/) do |str, typename|
  doc = MultiJson.load(str)
  @result = @system[typename].dress(doc) rescue $!
end

Given(/^I dress the following JSON document:$/) do |str|
  doc = MultiJson.load(str)
  @result = @system.dress(doc) rescue $!
end

Given(/^I dress the following JSON document with (.*?):$/) do |type, json|
  type = @system.fetch(type)
  json = ::MultiJson.load(json)
  @result = type.dress(json) rescue $!
end

### result

Then(/^it should be a success$/) do
  @result.should_not be_a(Exception)
end

Then(/^it should be a TypeError as:$/) do |table|
  @result.should be_a(Finitio::TypeError)
  expected = table.hashes.first
  expected.each_pair do |k,v|
    @result.send(k.to_sym).should eq(v)
  end
end

Then(/^the result should equal (\d+)$/) do |expected|
  @result.should eq(Integer(expected))
end

### representation

Then(/^the result should be a Tuple representation$/) do
  @result.should be_a(Hash)
end

Then(/^its '(.*?)' attribute should be a (.*?) representation$/) do |attr, type|
  type = @system.fetch(type)
  type.should include(@result[attr.to_sym])
end

Then(/^the result should be a representation for (.*?)$/) do |type|
  type = @system.fetch(type)
  type.should include(@result)
end


Then(/^the result should be the integer (\d+)$/) do |expected|
  @result.should eq(Integer(expected))
end

Then(/^the result should be the Boolean true$/) do
  @result.should eq(true)
end

Then(/^the result should be the Boolean false$/) do
  @result.should eq(false)
end

Then(/^the result should be the 13st of March 2014$/) do
  @result.should eq(Date.parse("2014-03-13"))
end

Then(/^the result should be the real (\d+.\d+)$/) do |expected|
  @result.should eq(Float(expected))
end

Then(/^the result should be the string '(.*?)'$/) do |expected|
  @result.should eq(expected)
end

Then(/^the result should be the 13st of March 2014 at 08:30$/) do
  @result.should eq(Time.parse("2014-03-13T08:30"))
end
