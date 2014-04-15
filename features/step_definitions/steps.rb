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

### parsing

def parse_expression(source = @parsing_source, rule = @rule_name_under_test)
  options = {root: rule, memoize: true}
  node    = Finitio::Syntax.parse(source, options)
  node.should be_a(Finitio::Syntax::Node)
  node
end

Given(/^the grammar rule is (.*?)$/) do |rule_name|
  @rule_name_under_test = rule_name
end

Given(/^the source is$/) do |src|
  @parsing_source = src
end

Then(/^it should compile to a (.*)$/) do |type_name|
  @ast_node ||= parse_expression
  @system[type_name].should include(@ast_node.value)
end

Then(/^evaluating it with x=(.*?) should yield (.*?)$/) do |value, expected|
  @ast_node ||= parse_expression
  proc = @ast_node.to_proc([:x])
  value, expected = [value, expected].map{|x| ::Kernel.eval(x) }
  proc.call(value).should eq(expected)
end

Then(/^evaluating it should yield (.*?)$/) do |expected|
  @ast_node ||= parse_expression
  proc = @ast_node.to_proc
  expected = ::Kernel.eval(expected)
  proc.call().should eq(expected)
end

### compiling

Then(/^it should compile fine$/) do
  @system = Finitio::DEFAULT_SYSTEM.parse(@system_source)
end

### dressing

Given(/^I dress JSON's '(.*?)'$/) do |str|
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
