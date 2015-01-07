require 'spec_helper'
module Finitio
  describe StructType, "equality" do

    let(:type1)  { StructType.new([intType, floatType]) }
    let(:type2)  { StructType.new([intType, floatType]) }
    let(:type3)  { StructType.new([floatType, intType]) }

    it 'should apply structural equality' do
      expect(type1 == type2).to be_true
      expect(type2 == type1).to be_true
    end

    it 'should apply distinguish different types' do
      expect(type1 == type3).to be_false
      expect(type2 == type3).to be_false
    end

    it 'should be a total function, with nil for non types' do
      expect(type1 == 12).to be_false
    end

    it 'should implement hash accordingly' do
      expect([type1, type2].map(&:hash).uniq.size).to eq(1)
    end

  end
end
