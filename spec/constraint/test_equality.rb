require 'spec_helper'
module Finitio
  describe Constraint, "==" do

    def constraint(proc, name = nil)
      Constraint.new(proc, name)
    end

    it 'recognizes same procs' do
      expect(constraint(byte_min)).to eq(constraint(byte_min))
    end

    it 'recognizes non constraints' do
      expect(constraint(byte_min)).not_to eq(nil)
      expect(constraint(byte_min)).not_to eq(1)
    end

    it 'recognizes non equivalent constraints' do
      expect(constraint(byte_min)).not_to eq(constraint(byte_max))
    end

    it 'does not take name into accound' do
      expect(constraint(byte_min, :foo)).to eq(constraint(byte_min, :bar))
    end

    it 'implements hash accordingly' do
      c1 = constraint(byte_min)
      c2 = constraint(byte_min)
      expect(c1.hash).to eq(c2.hash)
    end

    it 'is smart enough to have different hash codes for different constraints' do
      c1 = constraint(byte_min)
      c2 = constraint(byte_max)
      expect(c1.hash).not_to eq(c2.hash)
    end

  end
end
