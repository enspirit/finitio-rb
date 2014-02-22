require 'spec_helper'
module Qrb
  describe AdType, "default_name" do

    subject{ type.default_name }

    let(:type){
      AdType.new(Color, rgb: [intType, RgbContract], hex: [floatType, HexContract])
    }

    it{ should eq('Color') }

  end
end
