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
          compiled.should be_a(StructType)
          compiled.component_types.should eq([intType, floatType])
        end
      end
    end

    describe "AST" do
      let(:input){ '<.Integer, .Float>' }

      let(:ast){ subject.to_ast }

      it{ ast.should eq([
          :struct_type,
          [:builtin_type, "Integer"],
          [:builtin_type, "Float"]
        ])
      }
    end

  end
end
