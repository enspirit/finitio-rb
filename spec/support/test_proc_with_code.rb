require 'spec_helper'
module Finitio
  describe ProcWithCode do

    it 'acts like a proc' do
      p = ProcWithCode.new{|t| t>0 }
      expect(p).to be_a(Proc)
      expect(p.call(2)).to eq(true)
      expect(p.call(-2)).to eq(false)
    end

    it 'lets compile from source code' do
      p = ProcWithCode.new("t", "t>0")
      expect(p).to be_a(Proc)
      expect(p.call(2)).to eq(true)
      expect(p.call(-2)).to eq(false)
    end

    it 'yields equal procs for same source code' do
      p1 = ProcWithCode.new("t", "t>0")
      p2 = ProcWithCode.new("t", "t>0")
      expect(p1).to eql(p2)
      expect(p1.hash).to eql(p2.hash)
    end

  end
end
