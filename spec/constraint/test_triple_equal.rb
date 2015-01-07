require 'spec_helper'
module Finitio
  describe Constraint, "===" do

    let(:constraint){ Constraint.new(byte_full) }

    it 'delegates to the proc' do
      expect(constraint.===(17)).to be_true
      expect(constraint.===(1700)).to be_false
    end

  end
end
