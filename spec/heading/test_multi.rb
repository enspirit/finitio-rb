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

      it{ should be_false }
    end

    context 'with required attributes only' do
      let(:attributes){
        [ red, blue ]
      }

      it{ should be_false }
    end

    context 'with some optional attributes' do
      let(:attributes){
        [ red, maybe_blue ]
      }

      it{ should be_true }
    end

    context 'with allow_extra set to true' do
      let(:attributes){
        [ red, blue ]
      }
      let(:options){
        {allow_extra: true}
      }

      it{ should be_true }
    end

  end
end
