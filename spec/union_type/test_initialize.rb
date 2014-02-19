require 'spec_helper'
module Qrb
  describe UnionType, "initialize" do

    let(:union){ UnionType.new("myType", [intType, floatType]) }

    it 'sets the variable instances' do
      union.name.should eq("myType")
      union.candidates.should eq([intType, floatType])
    end

  end
end
