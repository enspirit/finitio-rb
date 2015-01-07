require 'spec_helper'
module Finitio
  describe BuiltinType, "default_name" do

    let(:type){ BuiltinType.new(Integer, "int") }

    it 'uses the ruby name' do
      expect(type.default_name).to eq("Integer")
    end

  end
end
