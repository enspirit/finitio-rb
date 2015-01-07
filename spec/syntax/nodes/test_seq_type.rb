require 'spec_helper'
module Finitio
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
          expect(compiled).to be_a(SeqType)
          expect(compiled.elm_type).to be_a(BuiltinType)
          expect(compiled.elm_type.ruby_type).to be(Integer)
        end
      end
    end

    describe "AST" do
      let(:input){ '[.Integer]' }

      let(:ast){ subject.to_ast }

      it{ expect(ast).to eq([
          :seq_type,
          [:builtin_type, "Integer"]
        ])
      }
    end

  end
end
