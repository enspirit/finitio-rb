require 'spec_helper'
module Qrb
  describe SetType, "equality" do

    let(:type) { SetType.new(intType)   }
    let(:type2){ SetType.new(intType)   }
    let(:type3){ SetType.new(floatType) }

    it 'should apply structural equality' do
      (type == type2).should be_true
    end

    it 'should apply distinguish different types' do
      (type == type3).should be_false
    end

    it 'should be a total function, with false for non types' do
      (type == 12).should be_false
    end

    it 'should implement hash accordingly' do
      (type.hash == type2.hash).should be_true
    end

  end
end
