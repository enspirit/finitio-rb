require 'spec_helper'
module Qrb
  describe UserType, "default_name" do

    subject{ type.default_name }

    let(:type){ UserType.new({}, "Foo") }

    it{ should eq('Unnamed') }

  end
end
