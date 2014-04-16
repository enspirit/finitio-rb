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

Then(/^it evaluates to a (.*)$/) do |type_name|
  @ast_node ||= parse_expression
  @system[type_name].should include(@ast_node.value)
end

Then(/^evaluating it with x=(.*?) yields (.*?)$/) do |value, expected|
  @ast_node ||= parse_expression
  proc = @ast_node.to_proc([:x])
  value, expected = [value, expected].map{|x| ::Kernel.eval(x) }
  proc.call(value).should eq(expected)
end

Then(/^evaluating it yields (.*?)$/) do |expected|
  @ast_node ||= parse_expression
  proc = @ast_node.to_proc
  expected = ::Kernel.eval(expected)
  proc.call().should eq(expected)
end

