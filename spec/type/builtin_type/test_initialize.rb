require 'spec_helper'
module Qrb
  describe BuiltinType, "initialize" do

    let(:type){ BuiltinType.new("int", Integer) }

    it 'should set instance variables' do
      type.name.should eq("int")
      type.ruby_type.should be(Integer)
    end

  end
end
