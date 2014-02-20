require 'spec_helper'
module Qrb
  describe SubType, "default_name" do

    let(:type){ SubType.new(intType, posint: ->(i){}) }

    subject{ type.default_name }

    it 'uses the first constraint name' do
      subject.should eq("Posint")
    end

  end
end
