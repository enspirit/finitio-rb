Then(/^the result should be a Nil representation$/) do
  @result.should be_nil
end

Then(/^the result should be a Tuple representation$/) do
  @result.should be_a(Hash)
end

Then(/^its '(.*?)' attribute should be a Date representation$/) do |attr|
  @result[attr.to_sym].should be_a(Date)
end

Then(/^the result should be a representation for (.*?)$/) do |type|
  type = @realm.fetch(type)
  case type
  when Qrb::TupleType
    @result.should be_a(Hash)
    @result.keys.all?{|k| k.should be_a(Symbol) }
  when Qrb::RelationType
    @result.should be_a(Set)
    @result.all?{|t|
      t.should be_a(Hash)
      t.keys.all?{|k| k.should be_a(Symbol) }
    }
  else
    raise "Unexpected type `#{type}`"
  end
end
