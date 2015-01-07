require 'spec_helper'
module Finitio
  describe Heading, "[]" do

    let(:a){ Attribute.new(:a, intType) }
    let(:h){ Heading.new([a]) }

    it 'returns the attribute by name' do
      expect(h[:a]).to be(a)
    end

    it 'returns nil if no such attribute' do
      expect(h[:b]).to be_nil
    end

  end
end
