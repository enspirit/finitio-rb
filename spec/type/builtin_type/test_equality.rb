require 'spec_helper'
module Qrb
  describe BuiltinType, "equality" do

    let(:intType) { BuiltinType.new(Integer) }
    let(:intType2){ BuiltinType.new(Integer) }
    let(:fltType) { BuiltinType.new(Float)   }

    it 'should apply structural equality' do
      (intType == intType2).should be_true
    end

    it 'should apply distinguish different types' do
      (intType == fltType).should be_false
    end

    it 'should be a total function, with nil for non types' do
      (intType == 12).should be_false
    end

    it 'should implement hash accordingly' do
      (intType.hash == intType2.hash).should be_true
    end

  end
end
