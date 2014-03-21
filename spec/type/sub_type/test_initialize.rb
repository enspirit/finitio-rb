require 'spec_helper'
module Finitio
  describe SubType, "initialize" do

    let(:c1){ ->(i){ i>0 } }
    let(:c2){ ->(i){ i<255 } }

    let(:sub){ SubType.new(intType, positive: c1, small: c2) }

    it 'sets the variable instances' do
      sub.super_type.should eq(intType)
      sub.constraints.should eq(positive: c1, small: c2)
    end

  end
end
