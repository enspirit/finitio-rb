require 'spec_helper'
module Finitio
  describe BuiltinType, "initialize" do

    let(:type){ BuiltinType.new(Integer) }

    it 'should set instance variables' do
      expect(type.ruby_type).to be(Integer)
    end

  end
end
