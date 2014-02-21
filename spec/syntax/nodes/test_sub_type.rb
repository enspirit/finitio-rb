require 'spec_helper'
module Qrb
  describe Syntax, "sub_type" do

    subject{
      Syntax.parse(input, root: "sub_type")
    }

    let(:compiled){
      subject.compile(realm_builder)
    }

    context '.Integer( i | i >= 0 )' do
      let(:input){ '.Integer( i | i >= 0 )' }

      it 'compiles to a SubType' do
        compiled.should be_a(SubType)
        compiled.super_type.should be_a(BuiltinType)
        compiled.super_type.ruby_type.should be(Integer)
      end
    end

  end
end
