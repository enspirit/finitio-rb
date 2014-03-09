require 'spec_helper'
module Qrb
  describe AdType, "default_name" do

    subject{ type.default_name }

    let(:type){
      AdType.new(Color, rgb: [intType,   Color.method(:rgb), Qrb::IDENTITY ],
                        hex: [floatType, Color.method(:hex), Qrb::IDENTITY ])
    }

    it{ should eq('Color') }

  end
end
