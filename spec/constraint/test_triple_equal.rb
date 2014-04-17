require 'spec_helper'
module Finitio
  describe Constraint, "===" do

    let(:constraint){ Constraint.new(byte_full) }

    it 'delegates to the proc' do
      constraint.===(17).should be_true
      constraint.===(1700).should be_false
    end

  end
end
