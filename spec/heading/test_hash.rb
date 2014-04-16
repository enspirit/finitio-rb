require 'spec_helper'
module Finitio
  describe Heading, "hash" do

    let(:r)      { Attribute.new(:r, intType)        }
    let(:b)      { Attribute.new(:b, intType)        }
    let(:maybe_r){ Attribute.new(:r, intType, false) }

    def heading(attributes, options = nil)
      Heading.new(attributes, options)
    end

    it 'returns same code on equal headings' do
      heading([r]).hash.should eq(heading([r]).hash)
    end

    it 'does not put significance to attributes ordering' do
      heading([r, b]).hash.should eq(heading([b, r]).hash)
    end

    it 'is good enough to distinguish between attribute obligations' do
      heading([r]).hash.should_not eq(heading([maybe_r]).hash)
    end

    it 'is good enough to distinguish between extra allowance' do
      h1 = heading([r], allow_extra: true)
      h2 = heading([r], allow_extra: false)
      h1.hash.should_not eq(h2.hash)
    end

    it 'is be good enough to distinguish between different headings' do
      a1 = Attribute.new(:r, intType)
      a2 = Attribute.new(:r, floatType)
      heading([a1]).hash.should_not eq(heading([a2]).hash)
    end

  end
end
