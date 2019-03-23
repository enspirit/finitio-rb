require 'spec_helper'
module Finitio
  describe SeqType, "suppremum" do

    subject{
      left.suppremum(right)
    }

    let(:left) {
      SeqType.new(intType)
    }

    context 'when right is equal' do
      let(:right) {
        SeqType.new(intType)
      }

      it 'keeps left' do
        expect(subject).to be(left)
      end
    end

    context 'when right is a set type of same element type' do
      let(:right) {
        SetType.new(intType)
      }

      it 'keeps left' do
        expect(subject).to eql(SeqType.new(intType))
      end
    end

    context 'when right is not a seq type' do
      let(:right) {
        stringType
      }

      it 'builds a UnionType' do
        expect(subject).to eql(UnionType.new [left, right])
      end
    end

    context 'when right is a seq type of a different element type' do
      let(:right) {
        SeqType.new(floatType)
      }

      it 'builds a SeqType[UnionType]' do
        expect(subject).to eql(SeqType.new(UnionType.new [intType, floatType]))
      end
    end

  end
end
