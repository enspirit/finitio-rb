require 'spec_helper'
module Finitio
  describe Attribute, "equality" do

    let(:attr1){ Attribute.new(:red, intType) }
    let(:attr2){ Attribute.new(:red, intType) }
    let(:attr3){ Attribute.new(:blue, intType) }

    it 'should apply structural equality' do
      (attr1 == attr2).should be_true
    end

    it 'should distinguish different attributes' do
      (attr1 == attr3).should be_false
    end

    it 'should return nil if not equal' do
      (attr1 == 12).should be_nil
    end

    it 'should implement hash accordingly' do
      attr1.hash.should eq(attr2.hash)
    end

  end
end
