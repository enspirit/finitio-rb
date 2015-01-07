require 'spec_helper'
module Finitio
  describe TypeFactory, "DSL#attributes" do

    let(:factory){ TypeFactory.new }

    shared_examples_for "The a:Integer, b:Float attributes" do

      it{ should be_a(Array) }

      it 'should be the correct pair' do
        expect(subject).to eq([ Attribute.new(:a, intType), Attribute.new(:b, floatType) ])
      end
    end

    context 'when used with ruby classes' do
      subject{
        factory.attributes(a: Integer, b: Float)
      }

      it_should_behave_like "The a:Integer, b:Float attributes"
    end

    context 'when used with types' do
      subject{
        factory.attributes(a: intType, b: floatType)
      }

      it_should_behave_like "The a:Integer, b:Float attributes"
    end

    context 'when used with a mix of both types' do
      subject{
        factory.attributes(a: Integer, b: floatType)
      }

      it_should_behave_like "The a:Integer, b:Float attributes"
    end

  end
end
