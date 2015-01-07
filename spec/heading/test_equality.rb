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
      expect(heading([r, b])).to eq(heading([b, r]))
    end

    it 'distinguishes between different attribute sets' do
      expect(heading([r])).not_to eq(heading([b]))
    end

    it 'distinguishes between attribute obligations' do
      expect(heading([r])).not_to eq(heading([maybe_r]))
    end

    it 'distinguishes between extra allowance' do
      h1 = heading([r], allow_extra: true)
      h2 = heading([r], allow_extra: false)
      expect(h1).not_to eq(h2)
    end

    it 'distinguishes between attribute types' do
      a1 = Attribute.new(:r, intType)
      a2 = Attribute.new(:r, floatType)
      expect(heading([a1])).not_to eq(heading([a2]))
    end

  end
end
