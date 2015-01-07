require 'spec_helper'
module Finitio
  describe Attribute, "equality" do

    let(:attr1){ Attribute.new(:red, intType) }
    let(:attr2){ Attribute.new(:red, intType) }
    let(:attr3){ Attribute.new(:blue, intType) }
    let(:attr4){ Attribute.new(:red, intType, false) }

    it 'should apply structural equality' do
      expect(attr1 == attr2).to eq(true)
    end

    it 'should distinguish different attributes' do
      expect(attr1 == attr3).to eq(false)
      expect(attr1 == attr4).to eq(false)
    end

    it 'should false against non Attribute' do
      expect(attr1 == 12).to eq(false)
    end

    it 'should implement hash accordingly' do
      expect(attr1.hash).to eq(attr2.hash)
      expect(attr1.hash).not_to eq(attr4.hash)
    end

  end
end
