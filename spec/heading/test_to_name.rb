require 'spec_helper'
module Finitio
  describe Heading, "to_name" do

    subject{ Heading.new(attributes).to_name }

    context 'with no attribute' do
      let(:attributes){
        [ ]
      }

      it{ should eq('') }
    end

    context 'with one attribute' do
      let(:attributes){
        [ Attribute.new(:red, intType) ]
      }

      it{ should eq('red: intType') }
    end

    context 'with multiple attributes' do
      let(:attributes){
        [ Attribute.new(:red, intType), Attribute.new(:blue, floatType) ]
      }

      it{ should eq('red: intType, blue: floatType') }
    end

  end
end
