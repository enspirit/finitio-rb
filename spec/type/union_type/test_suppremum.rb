require 'spec_helper'
module Finitio
  describe UnionType, "suppremum" do

    subject{
      left.suppremum(right)
    }

    let(:left){
      UnionType.new([intType, nilType])
    }

    context 'when right is not a union type' do
      let(:right){
        stringType
      }

      it 'works' do
        expect(subject).to be_a(UnionType)
        expect(subject.candidates).to eql(left.candidates + [right])
      end
    end

    context 'when right is a union type' do
      let(:right){
        UnionType.new([stringType, nilType])
      }

      it 'works' do
        expect(subject).to be_a(UnionType)
        expect(subject.candidates).to eql([intType, nilType, stringType])
      end
    end

    context 'when union type is on the right' do
      let(:left){
        stringType
      }

      let(:right){
        UnionType.new([intType, nilType])
      }

      it 'works' do
        expect(subject).to be_a(UnionType)
        expect(subject.candidates).to eql([intType, nilType, stringType])
      end
    end

  end
end
