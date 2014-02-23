require 'spec_helper'
module Qrb
  describe "Q/builtins" do

    let(:realm){ Qrb.realm('Q/builtins') }

    describe 'Boolean' do
      let(:type){ realm['Boolean'] }

      it 'recognizes true' do
        type.from_q(true).should eq(true)
      end

      it 'recognizes false' do
        type.from_q(false).should eq(false)
      end

      it 'raises on something else' do
        ->{ type.from_q("foo") }.should raise_error(TypeError)
      end
    end

  end
end
