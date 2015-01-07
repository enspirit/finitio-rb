require 'spec_helper'
module Finitio
  describe TypeFactory, "DSL#multi_tuple" do

    let(:factory){ TypeFactory.new }

    let(:heading){
      Heading.new([ Attribute.new(:a, intType, false) ])
    }

    shared_examples_for "The Tuple[a :? Int] type" do

      it{ should be_a(MultiTupleType) }

      it 'should have the correct heading' do
        expect(subject.heading).to eq(heading)
      end
    end

    before do
      subject
    end

    context 'when used with the standard signature' do
      subject{
        factory.multi_tuple(heading, "MyTuple")
      }

      it_should_behave_like "The Tuple[a :? Int] type"

      it 'should have the correct name' do
        expect(subject.name).to eq("MyTuple")
      end
    end

  end
end
