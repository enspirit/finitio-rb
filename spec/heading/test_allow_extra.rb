require 'spec_helper'
module Finitio
  describe Heading, "allow_extra" do

    let(:r){ Attribute.new(:r, intType) }

    def heading(attributes, options = nil)
      Heading.new(attributes, options)
    end

    it 'is false by default' do
      heading([r]).should_not be_allow_extra
    end

    it 'can be set to true' do
      heading([r], allow_extra: true).should be_allow_extra
    end

    it 'can be set to false explicitely' do
      heading([r], allow_extra: false).should_not be_allow_extra
    end

  end
end
