require 'spec_helper'
module Finitio
  describe Attribute, "optional?" do

    it 'is false by default' do
      Attribute.new(:red, intType).should_not be_optional
    end

    it 'is is the reverse of required' do
      Attribute.new(:red, intType, false).should be_optional
    end

    it 'is is the reverse of !required' do
      Attribute.new(:red, intType, true).should_not be_optional
    end

  end
end
