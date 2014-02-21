require 'spec_helper'
module Qrb
  describe Syntax, "builtin_type" do

    subject{
      Syntax.parse(".Integer", root: "builtin_type")
    }

    it 'parses typical ruby builtins' do
      subject.should eq('.Integer')
    end

    it 'compiles to a BuiltinType' do
      subject.compile(realm_builder).should be_a(BuiltinType)
    end

  end
end
