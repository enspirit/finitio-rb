require 'spec_helper'
module Finitio
  describe TypeFactory, "DSL#attribute" do

    let(:factory){ TypeFactory.new }

    shared_examples_for "The a:Integer attribute" do

      it{ should be_a(Attribute) }

      it 'should have the correct name' do
        subject.name.should eq(:a)
      end

      it 'should have the correct type' do
        subject.type.should eq(intType)
      end
    end

    context 'when used with a ruby class' do
      subject{
        factory.attribute(:a, Integer)
      }

      it_should_behave_like "The a:Integer attribute"

      it{ should be_required }
    end

    context 'when used with a type' do
      subject{
        factory.attribute(:a, intType)
      }

      it_should_behave_like "The a:Integer attribute"

      it{ should be_required }
    end

    context 'when used for an optional attribute' do
      subject{
        factory.attribute(:a, intType, false)
      }

      it_should_behave_like "The a:Integer attribute"

      it{ should_not be_required }
    end

  end
end
