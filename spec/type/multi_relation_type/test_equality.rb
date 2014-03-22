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
      (type1 == type2).should be_true
      (type2 == type1).should be_true
    end

    it 'should apply distinguish different types' do
      (type1 == type3).should be_false
      (type2 == type3).should be_false
      (type1 == type4).should be_false
    end

    it 'should be a total function, with false for non types' do
      (type1 == 12).should eq(false)
    end

    it 'should implement hash accordingly' do
      [type1, type2].map(&:hash).uniq.size.should eq(1)
      type1.hash.should_not eq(type4.hash)
    end

  end
end
