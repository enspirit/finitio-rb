require 'spec_helper'
module Qrb
  describe Syntax, "set_type" do

    subject{
      Syntax.parse(input, root: "set_type")
    }

    let(:compiled){
      subject.compile(realm_builder)
    }

    context '{.Integer}' do
      let(:input){ '{.Integer}' }

      it 'compiles to a SeqType' do
        compiled.should be_a(SetType)
        compiled.elm_type.should be_a(BuiltinType)
        compiled.elm_type.ruby_type.should be(Integer)
      end
    end

  end
end
