require 'spec_helper'
module Finitio
  describe AnyType, "equality" do

    let(:anyType) { AnyType.new }
    let(:anyType2){ AnyType.new("foo") }
    let(:fltType) { BuiltinType.new(Float)   }

    it 'should apply structural equality' do
      (anyType == anyType2).should be_true
    end

    it 'should apply distinguish different types' do
      (anyType == fltType).should be_false
    end

    it 'should be a total function, with nil for non types' do
      (anyType == 12).should be_false
    end

    it 'should implement hash accordingly' do
      (anyType.hash == anyType2.hash).should be_true
    end

  end
end
