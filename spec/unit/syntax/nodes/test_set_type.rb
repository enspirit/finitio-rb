require 'spec_helper'
module Qrb
  describe Syntax, "set_type" do

    subject{
      Syntax.parse(input, root: "set_type")
    }

    describe "compilation result" do
      let(:compiled){
        subject.compile(type_factory)
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

    describe "AST" do
      let(:input){ '{.Integer}' }

      let(:ast){ subject.to_ast }

      it{ ast.should eq([
          :set_type,
          [:builtin_type, "Integer"]
        ])
      }
    end

  end
end
