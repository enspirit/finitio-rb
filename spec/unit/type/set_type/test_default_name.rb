require 'spec_helper'
module Qrb
  describe SetType, 'default_name' do

    let(:type){
      SetType.new(intType, "foo")
    }

    subject{ type.default_name }

    it{ should eq('{intType}') }

  end
end
