require 'spec_helper'
module Finitio
  describe StructType, "equality" do

    let(:type1)  { StructType.new([intType, floatType]) }
    let(:type2)  { StructType.new([intType, floatType]) }
    let(:type3)  { StructType.new([floatType, intType]) }

    it 'should apply structural equality' do
      (type1 == type2).should be_true
      (type2 == type1).should be_true
    end

    it 'should apply distinguish different types' do
      (type1 == type3).should be_false
      (type2 == type3).should be_false
    end

    it 'should be a total function, with nil for non types' do
      (type1 == 12).should be_false
    end

    it 'should implement hash accordingly' do
      [type1, type2].map(&:hash).uniq.size.should eq(1)
    end

  end
end
