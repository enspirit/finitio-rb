require 'spec_helper'
module Finitio
  describe SetType, "equality" do

    let(:type) { SetType.new(intType)   }
    let(:type2){ SetType.new(intType)   }
    let(:type3){ SetType.new(floatType) }

    it 'should apply structural equality' do
      expect(type == type2).to be_true
    end

    it 'should apply distinguish different types' do
      expect(type == type3).to be_false
    end

    it 'should be a total function, with false for non types' do
      expect(type == 12).to be_false
    end

    it 'should implement hash accordingly' do
      expect(type.hash == type2.hash).to be_true
    end

  end
end
