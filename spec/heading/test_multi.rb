require 'spec_helper'
module Finitio
  describe Heading, "multi?" do

    subject{ Heading.new(attributes).multi? }

    context 'with no attribute' do
      let(:attributes){
        [ ]
      }

      it{ should be_false }
    end

    context 'with required attributes' do
      let(:attributes){
        [ Attribute.new(:red, intType), Attribute.new(:blue, floatType) ]
      }

      it{ should be_false }
    end

    context 'with some optional attributes' do
      let(:attributes){
        [ Attribute.new(:red, intType), Attribute.new(:blue, floatType, false) ]
      }

      it{ should be_true }
    end

  end
end
