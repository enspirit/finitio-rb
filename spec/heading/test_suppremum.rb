require 'spec_helper'
module Finitio
  describe Heading, "suppremum" do

    subject{
      left.suppremum(right)
    }

    let(:left){
      Heading.new([Attribute.new(:a, intType),
                   Attribute.new(:b, stringType)])
    }

    context 'when both are equal' do
      let(:right){
        Heading.new([Attribute.new(:a, intType),
                     Attribute.new(:b, stringType)])
      }

      it 'works' do
        expect(subject).to be(left)
      end
    end

    context 'when they are different' do
      let(:right){
        Heading.new([Attribute.new(:a, nilType),
                     Attribute.new(:b, stringType)])
      }

      it 'works' do
        expect(subject).to be_a(Heading)
        expect(subject[:a].type).to eql(UnionType.new [intType, nilType])
        expect(subject[:b].type).to eql(stringType)
      end
    end

    context 'when they are different II' do
      let(:right){
        Heading.new([Attribute.new(:c, nilType),
                     Attribute.new(:b, stringType)])
      }

      it 'works' do
        expect(subject).to be_a(Heading)
        expect(subject[:a].type).to eql(intType)
        expect(subject[:a].required).to eql(false)
        expect(subject[:b].type).to eql(stringType)
        expect(subject[:b].required).to eql(true)
        expect(subject[:c].type).to eql(nilType)
        expect(subject[:c].required).to eql(false)
      end
    end

  end
end
