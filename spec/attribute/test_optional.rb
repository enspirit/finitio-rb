require 'spec_helper'
module Finitio
  describe Attribute, "optional?" do

    it 'is false by default' do
      expect(Attribute.new(:red, intType)).not_to be_optional
    end

    it 'is is the reverse of required' do
      expect(Attribute.new(:red, intType, false)).to be_optional
    end

    it 'is is the reverse of !required' do
      expect(Attribute.new(:red, intType, true)).not_to be_optional
    end

  end
end
