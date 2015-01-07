require 'spec_helper'
module Finitio
  describe SubType, "initialize" do

    let(:sub){ SubType.new(intType, [byte_min, byte_max]) }

    it 'sets the variable instances' do
      expect(sub.super_type).to eq(intType)
      expect(sub.constraints).to eq([byte_min, byte_max])
    end

  end
end
