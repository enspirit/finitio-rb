require 'spec_helper'
module Finitio
  describe Attribute, "required?" do

    it 'is true by default' do
      expect(Attribute.new(:red, intType)).to be_required
    end

    it 'is can be set to true' do
      expect(Attribute.new(:red, intType, true)).to be_required
    end

    it 'is can be set to false' do
      expect(Attribute.new(:red, intType, false)).not_to be_required
    end

  end
end
