require 'spec_helper'
module Qrb
  describe BuiltinType, "default_name" do

    let(:type){ BuiltinType.new(Integer, "int") }

    it 'uses the ruby name' do
      type.default_name.should eq("Integer")
    end

  end
end
