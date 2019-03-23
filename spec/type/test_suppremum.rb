require 'spec_helper'
module Finitio
  describe Type, "suppremum" do

    subject{
      left.suppremum(right)
    }

    let(:left){
      intType
    }

    context 'when both are equal' do
      let(:right){
        intType
      }

      it 'works' do
        expect(subject).to be(left)
      end
    end

    context 'when they are different' do
      let(:right){
        nilType
      }

      it 'works' do
        expect(subject).to be_a(UnionType)
        expect(subject.candidates).to eql([left, right])
      end
    end

    context 'when one is any' do
      let(:right){
        anyType
      }

      it 'works' do
        expect(subject).to eql(anyType)
      end

      it 'works the other way round' do
        expect(anyType.suppremum(left)).to eql(anyType)
      end
    end

  end
end
