require 'spec_helper'
module Finitio
  describe AnyType, "equality" do

    let(:anyType) { AnyType.new }
    let(:anyType2){ AnyType.new("foo") }
    let(:fltType) { BuiltinType.new(Float)   }

    it 'should apply structural equality' do
      expect(anyType == anyType2).to be_true
    end

    it 'should apply distinguish different types' do
      expect(anyType == fltType).to be_false
    end

    it 'should be a total function, with nil for non types' do
      expect(anyType == 12).to be_false
    end

    it 'should implement hash accordingly' do
      expect(anyType.hash == anyType2.hash).to be_true
    end

  end
end
