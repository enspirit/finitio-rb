require 'spec_helper'
module Finitio
  describe BuiltinType, "initialize" do

    let(:type){ BuiltinType.new(Integer) }

    it 'should set instance variables' do
      type.ruby_type.should be(Integer)
    end

  end
end
