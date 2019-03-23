require 'spec_helper'
module Finitio
  describe Heading, "looks_similar?" do

    let(:heading){
      Heading.new([Attribute.new(:a, intType),
                   Attribute.new(:b, stringType)])
    }

    subject{
      heading.looks_similar?(h2)
    }

    context 'when equal' do
      let(:h2){ heading }

      it 'says yes' do
        expect(subject).to be_truthy
      end
    end

    context 'when shared attributes are in majority' do
      let(:h2){
        Heading.new([Attribute.new(:a, intType),
                     Attribute.new(:c, stringType)])
      }

      it 'says yes' do
        expect(subject).to be_truthy
      end
    end

    context 'when shared attributes are in minority' do
      let(:h2){
        Heading.new([Attribute.new(:d, intType),
                     Attribute.new(:c, stringType)])
      }

      it 'says no' do
        expect(subject).to be_falsy
      end
    end

  end
end