Given(/^the document has been defined as follows:$/) do |str|
  @schema = Qrb::DEFAULT_REALM.parse_schema(str)
end

Given(/^I dress the following JSON document:$/) do |str|
  doc = MultiJson.load(str)
  @result = @schema.dress(doc) rescue $!
end
