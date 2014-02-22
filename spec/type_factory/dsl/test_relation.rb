require 'spec_helper'
module Qrb
  describe TypeFactory, "DSL#relation" do

    let(:factory){ TypeFactory.new }

    let(:heading){
      Heading.new([ Attribute.new(:a, intType) ])
    }

    shared_examples_for "The Relation[a: Int] type" do

      it{ should be_a(RelationType) }

      it 'should have the correct heading' do
        subject.heading.should eq(heading)
      end
    end

    before do
      subject
    end

    context 'when used with the standard signature' do
      subject{
        factory.relation(heading, "MyRelation")
      }

      it_should_behave_like "The Relation[a: Int] type"

      it 'should have the correct name' do
        subject.name.should eq("MyRelation")
      end
    end

    context 'when used with a tuple type' do
      subject{
        factory.relation(TupleType.new(heading), "MyRelation")
      }

      it_should_behave_like "The Relation[a: Int] type"

      it 'should have the correct name' do
        subject.name.should eq("MyRelation")
      end
    end

    context 'when used with a hash and ruby classes' do
      subject{
        factory.relation(a: Integer)
      }

      it_should_behave_like "The Relation[a: Int] type"

      it 'should have the correct name' do
        subject.name.should eq("{{a: Integer}}")
      end
    end

    context 'when used with a hash and a name' do
      subject{
        factory.relation({a: Integer}, "MyRelation")
      }

      it_should_behave_like "The Relation[a: Int] type"

      it 'should have the correct name' do
        subject.name.should eq("MyRelation")
      end
    end

    context 'when used with a hash and types' do
      subject{
        factory.relation(a: intType)
      }

      it_should_behave_like "The Relation[a: Int] type"

      it 'should have the correct name' do
        subject.name.should eq("{{a: intType}}")
      end
    end

  end
end
