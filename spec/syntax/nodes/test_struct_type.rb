require 'spec_helper'
module Finitio
  describe Syntax, "struct_type" do

    subject{
      Syntax.parse(input, root: "struct_type")
    }

    describe "compilation result" do
      let(:compiled){
        subject.compile(type_factory)
      }

      context '<.Integer, .Float>' do
        let(:input){ '<.Integer, .Float>' }

        it 'compiles to a StructType' do
          expect(compiled).to be_a(StructType)
          expect(compiled.component_types).to eq([intType, floatType])
        end
      end
    end

    describe "AST" do
      let(:input){ '<.Integer, .Float>' }

      let(:ast){ subject.to_ast }

      it{ expect(ast).to eq([
          :struct_type,
          [:builtin_type, "Integer"],
          [:builtin_type, "Float"]
        ])
      }
    end

  end
end
