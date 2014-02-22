require 'spec_helper'
module Qrb
  describe Syntax, "union_type" do

    subject{
      Syntax.parse(input, root: "union_type")
    }

    let(:compiled){
      subject.compile(type_factory)
    }

    context '.Integer|.Float' do
      let(:input){ '.Integer|.Float' }

      it 'compiles to a UnionType' do
        compiled.should be_a(UnionType)
        compiled.should eq(UnionType.new([intType, floatType]))
      end
    end

  end
end
