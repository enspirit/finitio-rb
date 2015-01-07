require 'spec_helper'
module Finitio
  describe UnionType, "equality" do

    let(:uType)  { UnionType.new([intType, floatType]) }
    let(:uType2) { UnionType.new([floatType, intType]) }
    let(:uType3) { UnionType.new([floatType, intType]) }
    let(:uType4) { UnionType.new([intType])            }

    it 'should apply structural equality' do
      expect(uType  == uType2).to be_true
      expect(uType  == uType3).to be_true
      expect(uType2 == uType3).to be_true
    end

    it 'should apply distinguish different types' do
      expect(uType == uType4).to be_false
      expect(uType == intType).to be_false
    end

    it 'should be a total function, with nil for non types' do
      expect(uType == 12).to be_false
    end

    it 'should implement hash accordingly' do
      expect([uType, uType2, uType3].map(&:hash).uniq.size).to eq(1)
    end

  end
end
