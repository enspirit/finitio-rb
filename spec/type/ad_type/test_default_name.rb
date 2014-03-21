require 'spec_helper'
module Finitio
  describe AdType, "default_name" do

    subject{ type.default_name }

    let(:type){
      AdType.new(Color, rgb: [intType,   Color.method(:rgb), Finitio::IDENTITY ],
                        hex: [floatType, Color.method(:hex), Finitio::IDENTITY ])
    }

    it{ should eq('Color') }

  end
end
