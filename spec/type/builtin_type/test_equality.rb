require 'spec_helper'
module Finitio
  describe BuiltinType, "equality" do

    let(:intType) { BuiltinType.new(Integer) }
    let(:intType2){ BuiltinType.new(Integer) }
    let(:fltType) { BuiltinType.new(Float)   }

    it 'should apply structural equality' do
      expect(intType == intType2).to eq(true)
    end

    it 'should apply distinguish different types' do
      expect(intType == fltType).to eq(false)
    end

    it 'should be a total function, with nil for non types' do
      expect(intType == 12).to eq(false)
    end

    it 'should implement hash accordingly' do
      expect(intType.hash == intType2.hash).to eq(true)
    end

  end
end
