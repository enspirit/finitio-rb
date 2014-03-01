Given(/^the document has been defined as follows:$/) do |str|
  @schema = Qrb.parse_schema(str)
end

Given(/^I dress the following JSON document:$/) do |str|
  doc = MultiJson.load(str)
  @result = @schema.dress(doc) rescue $!
end
