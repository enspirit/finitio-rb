require 'spec_helper'
module Finitio
  describe SubType, "initialize" do

    let(:sub){ SubType.new(intType, [byte_min, byte_max]) }

    it 'sets the variable instances' do
      sub.super_type.should eq(intType)
      sub.constraints.should eq([byte_min, byte_max])
    end

  end
end
