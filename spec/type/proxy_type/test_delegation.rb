require 'spec_helper'
module Finitio
  describe ProxyType, "delegation pattern" do

    let(:proxy){ ProxyType.new('Int', intType) }

    it 'should delegate name' do
      proxy.name.should eq(intType.name)
    end

    it 'should delegate default_name' do
      proxy.default_name.should eq(intType.default_name)
    end

    it 'should delegate hash' do
      proxy.hash.should eq(intType.hash)
    end

    it 'should delegate ==' do
      (intType == proxy).should be_true
      (proxy == intType).should be_true
    end

    it 'should delegate dress' do
      proxy.dress(12).should eq(12)
    end

    it 'should delegate include?' do
      proxy.include?(12).should be_true
    end

    it 'should delegate to_s' do
      proxy.to_s.should eq(intType.to_s)
    end

  end
end
