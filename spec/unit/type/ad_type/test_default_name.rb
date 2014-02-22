require 'spec_helper'
module Qrb
  describe AdType, "default_name" do

    subject{ type.default_name }

    let(:type){
      AdType.new(Color, rgb: [intType,   Color.method(:rgb) ],
                        hex: [floatType, Color.method(:hex) ])
    }

    it{ should eq('Color') }

  end
end
