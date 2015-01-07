require 'spec_helper'
module Finitio
  describe AliasType, "delegation pattern" do

    let(:type){ AliasType.new(intType, 'Alias') }

    it 'should delegate hash' do
      expect(type.hash).to eq(intType.hash)
    end

    it 'should delegate ==' do
      expect(intType == type).to eq(true)
      expect(type == intType).to eq(true)
    end

    it 'should delegate dress' do
      expect(type.dress(12)).to eq(12)
    end

    it 'should delegate include?' do
      expect(type.include?(12)).to eq(true)
    end

    it 'should delegate to_s' do
      expect(type.to_s).to eq(intType.to_s)
    end

  end
end
