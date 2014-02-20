require 'spec_helper'
module Qrb
  describe UnionType, "equality" do

    let(:uType)  { UnionType.new("uType",  [intType, floatType]) }
    let(:uType2) { UnionType.new("uType2", [floatType, intType]) }
    let(:uType3) { UnionType.new("uType3", [floatType, intType]) }
    let(:uType4) { UnionType.new("uType4", [intType])            }

    it 'should apply structural equality' do
      (uType  == uType2).should be_true
      (uType  == uType3).should be_true
      (uType2 == uType3).should be_true
    end

    it 'should apply distinguish different types' do
      (uType == uType4).should be_false
      (uType == intType).should be_false
    end

    it 'should be a total function, with nil for non types' do
      (uType == 12).should be_false
    end

    it 'should implement hash accordingly' do
      [uType, uType2, uType3].map(&:hash).uniq.size.should eq(1)
    end

  end
end
