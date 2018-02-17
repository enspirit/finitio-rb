require 'spec_helper'
module Finitio
  describe Heading, "allow_extra? and allow_extra" do

    let(:r){ Attribute.new(:r, intType) }

    def heading(attributes, options = nil)
      Heading.new(attributes, options)
    end

    it 'is false by default' do
      expect(heading([r])).not_to be_allow_extra
      expect(heading([r]).allow_extra).to be_nil
      expect(heading([r]).extra_type).to be_nil
    end

    it 'can be set to true' do
      expect(heading([r], allow_extra: true)).to be_allow_extra
      expect(heading([r], allow_extra: true).allow_extra).to eq(anyType)
      expect(heading([r], allow_extra: true).extra_type).to eq(anyType)
    end

    it 'can be set to false explicitely' do
      expect(heading([r], allow_extra: false)).not_to be_allow_extra
      expect(heading([r]).allow_extra).to be_nil
      expect(heading([r]).extra_type).to be_nil
    end

    it 'can be set to an explicit type' do
      expect(heading([r], allow_extra: intType)).to be_allow_extra
      expect(heading([r], allow_extra: intType).allow_extra).to eql(intType)
      expect(heading([r], allow_extra: intType).extra_type).to eql(intType)
    end

  end
end
