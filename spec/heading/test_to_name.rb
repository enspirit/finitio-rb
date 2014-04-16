require 'spec_helper'
module Finitio
  describe Heading, "to_name" do

    let(:red)       { Attribute.new(:red,  intType)        }
    let(:blue)      { Attribute.new(:blue, intType)        }
    let(:maybe_blue){ Attribute.new(:blue, intType, false) }

    let(:heading){ Heading.new(attributes) }

    subject{ heading.to_name }

    context 'with no attribute' do
      let(:attributes){
        [ ]
      }

      it{ should eq('') }
    end

    context 'with one attribute' do
      let(:attributes){
        [ red ]
      }

      it{ should eq('red: intType') }
    end

    context 'with multiple attributes' do
      let(:attributes){
        [ red, blue ]
      }

      it{ should eq('red: intType, blue: intType') }
    end

    context 'with some optional attributes' do
      let(:attributes){
        [ red, maybe_blue ]
      }

      it{ should eq('red: intType, blue :? intType') }
    end

    context 'when allowing extra' do
      let(:heading){ Heading.new([red], allow_extra: true) }

      it{ should eq('red: intType, ...') }
    end

    context 'when allowing extra only' do
      let(:heading){ Heading.new([], allow_extra: true) }

      it{ should eq('...') }
    end

  end
end
