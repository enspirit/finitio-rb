require 'spec_helper'
module Finitio
  describe MultiTupleType, "equality" do

    let(:h1){ Heading.new([Attribute.new(:r, intType, false), Attribute.new(:b, intType)]) }
    let(:h2){ Heading.new([Attribute.new(:b, intType), Attribute.new(:r, intType, false)]) }
    let(:h3){ Heading.new([Attribute.new(:b, intType)])                             }

    let(:type1)  { MultiTupleType.new(h1) }
    let(:type2)  { MultiTupleType.new(h2) }
    let(:type3)  { MultiTupleType.new(h3) }

    it 'should apply structural equality' do
      (type1 == type2).should be_true
      (type2 == type1).should be_true
    end

    it 'should apply distinguish different types' do
      (type1 == type3).should be_false
      (type2 == type3).should be_false
    end

    it 'should be a total function, with nil for non types' do
      (type1 == 12).should be_false
    end

    it 'should implement hash accordingly' do
      [type1, type2].map(&:hash).uniq.size.should eq(1)
    end

  end
end
