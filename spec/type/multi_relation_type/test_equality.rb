require 'spec_helper'
module Finitio
  describe MultiRelationType, "equality" do

    let(:h1){ Heading.new([Attribute.new(:r, intType), Attribute.new(:b, intType, false)]) }
    let(:h2){ Heading.new([Attribute.new(:b, intType, false), Attribute.new(:r, intType)]) }
    let(:h3){ Heading.new([Attribute.new(:b, intType)])                             }
    let(:h4){ Heading.new([Attribute.new(:b, intType), Attribute.new(:r, intType)]) }

    let(:type1)  { MultiRelationType.new(h1) }
    let(:type2)  { MultiRelationType.new(h2) }
    let(:type3)  { MultiRelationType.new(h3) }
    let(:type4)  { MultiRelationType.new(h4) }

    it 'should apply structural equality' do
      expect(type1 == type2).to be_true
      expect(type2 == type1).to be_true
    end

    it 'should apply distinguish different types' do
      expect(type1 == type3).to be_false
      expect(type2 == type3).to be_false
      expect(type1 == type4).to be_false
    end

    it 'should be a total function, with false for non types' do
      expect(type1 == 12).to eq(false)
    end

    it 'should implement hash accordingly' do
      expect([type1, type2].map(&:hash).uniq.size).to eq(1)
      expect(type1.hash).not_to eq(type4.hash)
    end

  end
end
