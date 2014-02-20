require 'spec_helper'
module Qrb
  describe UnionType, "default_name" do

    subject{ type.default_name }

    let(:type){ UnionType.new([intType, floatType]) }

    it{ should eq('intType|floatType') }

  end
end
