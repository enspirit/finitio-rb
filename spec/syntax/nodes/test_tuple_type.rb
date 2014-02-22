require 'spec_helper'
module Qrb
  describe Syntax, "tuple_type" do

    subject{
      Syntax.parse(input, root: "tuple_type")
    }

    let(:compiled){
      subject.compile(type_factory)
    }

    context 'empty heading' do
      let(:input){ '{ }' }

      it 'compiles to a TupleType' do
        compiled.should be_a(TupleType)
        compiled.heading.should be_empty
      end
    end

    context '{a: .Integer}' do
      let(:input){ '{a: .Integer}' }

      it 'compiles to a TupleType' do
        compiled.should be_a(TupleType)
        compiled.heading.size.should eq(1)
      end
    end

    context '{a: .Integer, b: .Float}' do
      let(:input){ '{a: .Integer, b: .Float}' }

      it 'compiles to a TupleType' do
        compiled.should be_a(TupleType)
        compiled.heading.size.should eq(2)
      end
    end

  end
end
