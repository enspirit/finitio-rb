require 'spec_helper'
module Qrb
  describe Heading, "initialize" do

    subject{ Heading.new(attributes) }

    context 'with no attribute' do
      let(:attributes){
        [ ]
      }

      it{ should be_a(Heading) }
    end

    context 'with valid attributes' do
      let(:attributes){
        [ Attribute.new(:red, intType) ]
      }

      it{ should be_a(Heading) }
    end

    context 'with invalid attributes' do
      let(:attributes){
        [ Attribute.new(:red, intType), Attribute.new(:red, intType) ]
      }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(ArgumentError, "Attribute names must be unique")
      end
    end

  end
end
