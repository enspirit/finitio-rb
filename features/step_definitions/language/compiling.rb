Then(/^it compiles fine$/) do
  @system.should be_a(Finitio::System)
end

Then(/^it compiles to a tuple type$/) do
  @system.should be_a(Finitio::System)
  @main   = @system.main
  [ Finitio::TupleType,
    Finitio::MultiTupleType ].should include(@main.class)
end

Then(/^it compiles to a relation type$/) do
  @system.should be_a(Finitio::System)
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

Then(/^metadata at (.*?) should be as follows$/) do |path, table|
  @system.should be_a(Finitio::System)
  table.hashes.each do |expected|
    citizen  = path.split('/').map(&:to_sym).reduce(@system, &:[])
    metadata = citizen.metadata
    metadata.size.should eq(expected.size)
    metadata.keys.map(&:to_s).should eq(expected.keys.map(&:to_s))
    metadata.keys.each do |k,v|
      metadata[k].should eq(expected[k.to_s])
    end
  end
end
