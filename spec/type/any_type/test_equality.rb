require 'spec_helper'
module Finitio
  describe AnyType, "equality" do

    let(:anyType) { AnyType.new }
    let(:anyType2){ AnyType.new("foo") }
    let(:fltType) { BuiltinType.new(Float)   }

    it 'should apply structural equality' do
      expect(anyType == anyType2).to eq(true)
    end

    it 'should apply distinguish different types' do
      expect(anyType == fltType).to eq(false)
    end

    it 'should be a total function, with nil for non types' do
      expect(anyType == 12).to eq(false)
    end

    it 'should implement hash accordingly' do
      expect(anyType.hash == anyType2.hash).to eq(true)
    end

  end
end
