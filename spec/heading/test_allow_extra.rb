require 'spec_helper'
module Finitio
  describe Heading, "allow_extra" do

    let(:r){ Attribute.new(:r, intType) }

    def heading(attributes, options = nil)
      Heading.new(attributes, options)
    end

    it 'is false by default' do
      expect(heading([r])).not_to be_allow_extra
    end

    it 'can be set to true' do
      expect(heading([r], allow_extra: true)).to be_allow_extra
    end

    it 'can be set to false explicitely' do
      expect(heading([r], allow_extra: false)).not_to be_allow_extra
    end

  end
end
