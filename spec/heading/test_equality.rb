require 'spec_helper'
module Finitio
  describe Heading, "equality" do

    let(:r)      { Attribute.new(:r, intType)        }
    let(:b)      { Attribute.new(:b, intType)        }
    let(:maybe_r){ Attribute.new(:r, intType, false) }

    def heading(attributes, options = nil)
      Heading.new(attributes, options)
    end

    it 'does not put significance to attributes ordering' do
      heading([r, b]).should eq(heading([b, r]))
    end

    it 'distinguishes between different attribute sets' do
      heading([r]).should_not eq(heading([b]))
    end

    it 'distinguishes between attribute obligations' do
      heading([r]).should_not eq(heading([maybe_r]))
    end

    it 'distinguishes between extra allowance' do
      h1 = heading([r], allow_extra: true)
      h2 = heading([r], allow_extra: false)
      h1.should_not eq(h2)
    end

    it 'distinguishes between attribute types' do
      a1 = Attribute.new(:r, intType)
      a2 = Attribute.new(:r, floatType)
      heading([a1]).should_not eq(heading([a2]))
    end

  end
end
