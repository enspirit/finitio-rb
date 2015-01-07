require 'spec_helper'
module Finitio
  describe Constraint, "anonymous?" do

    subject{ constraint.anonymous? }

    context 'with an unnamed constraint' do
      let(:constraint){ Constraint.new(byte_full) }

      it{ should eq(true) }
    end

    context 'with a named constraint' do
      let(:constraint){ Constraint.new(byte_full, :byte) }

      it{ should eq(false) }
    end

  end
end
