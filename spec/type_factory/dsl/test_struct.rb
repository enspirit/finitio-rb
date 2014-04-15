require 'spec_helper'
module Finitio
  describe TypeFactory, "DSL#struct" do

    let(:factory){ TypeFactory.new }

    shared_examples_for "The <Int, Float> type" do

      it{ should be_a(StructType) }

      it 'should have the correct components' do
        subject.component_types.should eq([intType, floatType])
      end
    end

    before do
      subject
    end

    context 'when used with the standard signature' do
      subject{
        factory.struct([intType, floatType], "MyTuple")
      }

      it_should_behave_like "The <Int, Float> type"

      it 'should have the correct name' do
        subject.name.should eq("MyTuple")
      end
    end

    context 'when used with an array of ruby classes' do
      subject{
        factory.struct([Integer, Float])
      }

      it_should_behave_like "The <Int, Float> type"

      it 'should have the correct name' do
        subject.name.should eq("<Integer, Float>")
      end
    end

  end
end
