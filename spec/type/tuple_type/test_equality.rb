require 'spec_helper'
module Finitio
  describe TupleType, "equality" do

    let(:h1){ Heading.new([Attribute.new(:r, intType), Attribute.new(:b, intType)]) }
    let(:h2){ Heading.new([Attribute.new(:b, intType), Attribute.new(:r, intType)]) }
    let(:h3){ Heading.new([Attribute.new(:b, intType)])                             }

    let(:type1)  { TupleType.new(h1) }
    let(:type2)  { TupleType.new(h2) }
    let(:type3)  { TupleType.new(h3) }

    it 'should apply structural equality' do
      expect(type1 == type2).to be_true
      expect(type2 == type1).to be_true
    end

    it 'should apply distinguish different types' do
      expect(type1 == type3).to be_false
      expect(type2 == type3).to be_false
    end

    it 'should be a total function, with nil for non types' do
      expect(type1 == 12).to be_false
    end

    it 'should implement hash accordingly' do
      expect([type1, type2].map(&:hash).uniq.size).to eq(1)
    end

  end
end
