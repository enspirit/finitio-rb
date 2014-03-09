require 'spec_helper'
module Qrb
  describe Syntax, "seq_type" do

    subject{
      Syntax.parse(input, root: "seq_type")
    }

    describe "compilation result" do
      let(:compiled){
        subject.compile(type_factory)
      }

      context '[.Integer]' do
        let(:input){ '[.Integer]' }

        it 'compiles to a SeqType' do
          compiled.should be_a(SeqType)
          compiled.elm_type.should be_a(BuiltinType)
          compiled.elm_type.ruby_type.should be(Integer)
        end
      end
    end

    describe "AST" do
      let(:input){ '[.Integer]' }

      let(:ast){ subject.to_ast }

      it{ ast.should eq([
          :seq_type,
          [:builtin_type, "Integer"]
        ])
      }
    end

  end
end
