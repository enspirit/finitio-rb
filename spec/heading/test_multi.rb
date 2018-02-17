require 'spec_helper'
module Finitio
  describe Heading, "multi?" do

    let(:red){
      Attribute.new(:red, intType)
    }

    let(:blue){
      Attribute.new(:blue, floatType)
    }

    let(:maybe_blue){
      Attribute.new(:blue, floatType, false)
    }

    subject{ Heading.new(attributes, options).multi? }

    let(:options){ nil }

    context 'with no attribute' do
      let(:attributes){
        [ ]
      }

      it{ should eq(false) }
    end

    context 'with required attributes only' do
      let(:attributes){
        [ red, blue ]
      }

      it{ should eq(false) }
    end

    context 'with some optional attributes' do
      let(:attributes){
        [ red, maybe_blue ]
      }

      it{ should eq(true) }
    end

    context 'with allow_extra set to true' do
      let(:attributes){
        [ red, blue ]
      }
      let(:options){
        {allow_extra: true}
      }

      it{ should eq(true) }
    end

    context 'with allow_extra set to a type' do
      let(:attributes){
        [ red, blue ]
      }
      let(:options){
        {allow_extra: intType}
      }

      it{ should eq(true) }
    end

  end
end
