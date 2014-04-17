require 'spec_helper'
module Finitio
  describe Constraint, "==" do

    def constraint(proc, name = nil)
      Constraint.new(proc, name)
    end

    it 'recognizes same procs' do
      constraint(byte_min).should eq(constraint(byte_min))
    end

    it 'recognizes non constraints' do
      constraint(byte_min).should_not eq(nil)
      constraint(byte_min).should_not eq(1)
    end

    it 'recognizes non equivalent constraints' do
      constraint(byte_min).should_not eq(constraint(byte_max))
    end

    it 'does not take name into accound' do
      constraint(byte_min, :foo).should eq(constraint(byte_min, :bar))
    end

    it 'implements hash accordingly' do
      c1 = constraint(byte_min)
      c2 = constraint(byte_min)
      c1.hash.should eq(c2.hash)
    end

    it 'is smart enough to have different hash codes for different constraints' do
      c1 = constraint(byte_min)
      c2 = constraint(byte_max)
      c1.hash.should_not eq(c2.hash)
    end

  end
end
