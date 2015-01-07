require 'spec_helper'
module Finitio
  describe ProxyType, "delegation pattern" do

    let(:proxy){ ProxyType.new('Int', intType) }

    it 'should delegate name' do
      expect(proxy.name).to eq(intType.name)
    end

    it 'should delegate default_name' do
      expect(proxy.default_name).to eq(intType.default_name)
    end

    it 'should delegate hash' do
      expect(proxy.hash).to eq(intType.hash)
    end

    it 'should delegate ==' do
      expect(intType == proxy).to be_true
      expect(proxy == intType).to be_true
    end

    it 'should delegate dress' do
      expect(proxy.dress(12)).to eq(12)
    end

    it 'should delegate include?' do
      expect(proxy.include?(12)).to be_true
    end

    it 'should delegate to_s' do
      expect(proxy.to_s).to eq(intType.to_s)
    end

  end
end
