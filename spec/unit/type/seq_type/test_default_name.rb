require 'spec_helper'
module Qrb
  describe SeqType, 'default_name' do

    let(:type){
      SeqType.new(intType, "foo")
    }

    subject{ type.default_name }

    it{ should eq('[intType]') }

  end
end
