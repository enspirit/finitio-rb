require 'spec_helper'
module Finitio
  describe TypeFactory, "DSL#multi_relation" do

    let(:factory){ TypeFactory.new }

    let(:heading){
      Heading.new([
        Attribute.new(:a, intType, false)
      ])
    }

    shared_examples_for "The Relation[a :? Int] type" do

      it{ should be_a(MultiRelationType) }

      it 'should have the correct heading' do
        subject.heading.should eq(heading)
      end
    end

    before do
      subject
    end

    context 'when used with the standard signature' do
      subject{
        factory.multi_relation(heading, "MyRelation")
      }

      it_should_behave_like "The Relation[a :? Int] type"

      it 'should have the correct name' do
        subject.name.should eq("MyRelation")
      end
    end

  end
end
