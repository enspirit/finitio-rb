require 'spec_helper'
module Qrb
  describe RealmBuilder, "DSL#attributes" do

    let(:builder){ RealmBuilder.new }

    shared_examples_for "The a:Integer, b:Float attributes" do

      it{ should be_a(Array) }

      it 'should be the correct pair' do
        subject.should eq([ Attribute.new(:a, intType), Attribute.new(:b, floatType) ])
      end
    end

    context 'when used with ruby classes' do
      subject{
        builder.attributes(a: Integer, b: Float)
      }

      it_should_behave_like "The a:Integer, b:Float attributes"
    end

    context 'when used with types' do
      subject{
        builder.attributes(a: intType, b: floatType)
      }

      it_should_behave_like "The a:Integer, b:Float attributes"
    end

    context 'when used with a mix of both types' do
      subject{
        builder.attributes(a: Integer, b: floatType)
      }

      it_should_behave_like "The a:Integer, b:Float attributes"
    end

  end
end
