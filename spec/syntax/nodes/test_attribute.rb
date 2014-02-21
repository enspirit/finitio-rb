require 'spec_helper'
module Qrb
  describe Syntax, "attribute" do

    subject{
      Syntax.parse(input, root: "attribute")
    }

    let(:compiled){
      subject.compile(realm_builder)
    }

    context 'a: .Integer' do
      let(:input){ 'a: .Integer' }

      it 'compiles to an Attribute' do
        compiled.should be_a(Attribute)
        compiled.name.should eq(:a)
        compiled.type.should be_a(BuiltinType)
        compiled.type.ruby_type.should be(Integer)
      end
    end

  end
end
