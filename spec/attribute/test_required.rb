require 'spec_helper'
module Finitio
  describe Attribute, "required?" do

    it 'is true by default' do
      Attribute.new(:red, intType).should be_required
    end

    it 'is can be set to true' do
      Attribute.new(:red, intType, true).should be_required
    end

    it 'is can be set to false' do
      Attribute.new(:red, intType, false).should_not be_required
    end

  end
end
