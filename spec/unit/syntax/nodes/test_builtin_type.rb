require 'spec_helper'
module Qrb
  describe Syntax, "builtin_type" do

    subject{
      Syntax.parse(source, root: "builtin_type")
    }

    let(:compiled){
      subject.compile(type_factory)
    }

    context 'when an unqualified class name' do
      let(:source){ ".Integer" }

      it 'compiles to a BuiltinType' do
        compiled.should be_a(BuiltinType)
        compiled.ruby_type.should be(Integer)
      end
    end

    context 'when a qualified class name' do
      let(:source){ ".Qrb::Type" }

      it 'compiles to a BuiltinType' do
        compiled.should be_a(BuiltinType)
        compiled.ruby_type.should be(::Qrb::Type)
      end
    end

  end
end
