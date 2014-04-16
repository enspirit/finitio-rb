require 'spec_helper'
module Finitio
  describe AliasType, "delegation pattern" do

    let(:type){ AliasType.new(intType, 'Alias') }

    it 'should delegate hash' do
      type.hash.should eq(intType.hash)
    end

    it 'should delegate ==' do
      (intType == type).should be_true
      (type == intType).should be_true
    end

    it 'should delegate dress' do
      type.dress(12).should eq(12)
    end

    it 'should delegate include?' do
      type.include?(12).should be_true
    end

    it 'should delegate to_s' do
      type.to_s.should eq(intType.to_s)
    end

  end
end
