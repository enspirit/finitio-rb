Then(/^it compiles fine$/) do
  @system = Finitio::DEFAULT_SYSTEM.parse(@system_source)
end

Then(/^it compiles to a tuple type$/) do
  @system = Finitio::DEFAULT_SYSTEM.parse(@system_source)
  @main   = @system.main
  [ Finitio::TupleType,
    Finitio::MultiTupleType ].should include(@main.class)
end

Then(/^it compiles to a relation type$/) do
  @system = Finitio::DEFAULT_SYSTEM.parse(@system_source)
  @main   = @system.main
  [ Finitio::RelationType,
    Finitio::MultiRelationType ].should include(@main.class)
end

Then(/^`(.*?)` and `(.*?)` are mandatory$/) do |*attrs|
  attrs.each do |attr|
    @main.heading[attr.to_sym].should be_a(Finitio::Attribute)
    @main.heading[attr.to_sym].should be_required
  end
end

Then(/^`(.*?)` is mandatory, but `(.*?)` is optional$/) do |first, second|
  @main.heading[first.to_sym].should be_a(Finitio::Attribute)
  @main.heading[first.to_sym].should be_required
  @main.heading[second.to_sym].should be_a(Finitio::Attribute)
  @main.heading[second.to_sym].should be_optional
end

Then(/^`(.*?)` is mandatory$/) do |attr|
  @main.heading[attr.to_sym].should be_a(Finitio::Attribute)
  @main.heading[attr.to_sym].should be_required
end

Then(/^it does not allow extra attributes$/) do
  @main.heading.should_not be_allow_extra
end

Then(/^it allows extra attributes$/) do
  @main.heading.should be_allow_extra
end
