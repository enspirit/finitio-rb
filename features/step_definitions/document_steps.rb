Given(/^the document has been defined as follows:$/) do |str|
  @schema = Qrb::Syntax.compile(str)
end

Given(/^I use the document schema to validate the following JSON doc:$/) do |str|
  doc = MultiJson.load(str)
  @result = @schema.up(doc) rescue $!
end
