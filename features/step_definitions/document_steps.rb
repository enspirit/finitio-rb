Given(/^the document has been defined as follows:$/) do |str|
  @schema = Qrb.parse_schema(str)
end

Given(/^I use the document schema to validate the following JSON doc:$/) do |str|
  doc = MultiJson.load(str)
  @result = @schema.dress(doc) rescue $!
end
