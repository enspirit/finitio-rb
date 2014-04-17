require 'spec_helper'
module Finitio
  describe Constraint, "name" do

    subject{ constraint.name }

    context 'with an unnamed constraint' do
      let(:constraint){ Constraint.new(byte_full) }

      it{ should eq(:default) }
    end

    context 'with a named constraint' do
      let(:constraint){ Constraint.new(byte_full, :byte) }

      it{ should eq(:byte) }
    end

  end
end
