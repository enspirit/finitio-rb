require 'spec_helper'
module Finitio
  describe SubType, "equality" do

    def sub(parent, constraints, name = nil)
      SubType.new(parent, constraints, name)
    end

    it 'recognizes same sub types' do
      s1 = sub(intType, [byte_min])
      s2 = sub(intType, [byte_min])
      s1.should eq(s2)
    end

    it 'does not take name into account' do
      s1 = sub(intType, [byte_min], 'foo')
      s2 = sub(intType, [byte_min], 'bar')
      s1.should eq(s2)
    end

    it 'recognizes same sub types with multiple constraints' do
      s1 = sub(intType, [byte_min, byte_max])
      s2 = sub(intType, [byte_max, byte_min])
      s1.should eq(s2)
    end

    it 'distinguishes different sub types' do
      s1 = sub(intType, [byte_min])
      s2 = sub(intType, [byte_max])
      s1.should_not eq(s2)
    end

    it 'implements hash code accordingly' do
      s1 = sub(intType, [byte_min])
      s2 = sub(intType, [byte_min])
      s1.hash.should eq(s2.hash)
    end

    it 'is smart enough to have hashes for different sub types' do
      s1 = sub(intType, [byte_max])
      s2 = sub(intType, [byte_min])
      s1.hash.should_not eq(s2.hash)
    end

  end
end
