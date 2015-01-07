require 'spec_helper'
module Finitio
  describe Constraint, "named?" do

    subject{ constraint.named? }

    context 'with an unnamed constraint' do
      let(:constraint){ Constraint.new(byte_full) }

      it{ should eq(false) }
    end

    context 'with a named constraint' do
      let(:constraint){ Constraint.new(byte_full, :byte) }

      it{ should eq(true) }
    end

  end
end
