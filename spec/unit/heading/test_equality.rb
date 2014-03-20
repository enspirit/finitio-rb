require 'spec_helper'
module Finitio
  describe Heading, "equality" do

    let(:h1){ Heading.new([Attribute.new(:r, intType), Attribute.new(:b, intType)]) }
    let(:h2){ Heading.new([Attribute.new(:b, intType), Attribute.new(:r, intType)]) }
    let(:h3){ Heading.new([Attribute.new(:b, intType)])                             }

    it 'should apply structural equality' do
      (h1 == h2).should be_true
      (h2 == h1).should be_true
    end

    it 'should apply distinguish different types' do
      (h1 == h3).should be_false
      (h2 == h3).should be_false
    end

    it 'should be a total function, with nil for non types' do
      (h1 == 12).should be_nil
    end

    it 'should implement hash accordingly' do
      [h1, h2].map(&:hash).uniq.size.should eq(1)
    end

  end
end
