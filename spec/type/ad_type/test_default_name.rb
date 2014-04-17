require 'spec_helper'
module Finitio
  describe AdType, "default_name" do

    subject{ type.default_name }

    let(:type){
      AdType.new(Color, [])
    }

    it{ should eq('Color') }

  end
end
