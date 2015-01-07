require 'spec_helper'
module Finitio
  describe Syntax, "system" do

    subject{
      Syntax.parse(input, root: "system")
    }

    let(:ast){
      subject.to_ast
    }

    context 'with definitions and a type' do
      let(:input){ "Int = .Integer\n{r: Int}" }

      it 'has the expected AST' do
        expect(ast).to eq([
          :system,
          [:type_def, "Int", [:builtin_type, "Integer"]],
          [:tuple_type, [:heading, [:attribute, "r", [:type_ref, "Int"]]]]
        ])
      end
    end

    context 'with definitions only' do
      let(:input){ "Int = .Integer" }

      it 'has the expected AST' do
        expect(ast).to eq([
          :system,
          [:type_def, "Int", [:builtin_type, "Integer"]]
        ])
      end
    end

    context 'with a type only' do
      let(:input){ "{r: .Integer}" }

      it 'has the expected AST' do
        expect(ast).to eq([
          :system,
          [:tuple_type, [:heading, [:attribute, "r", [:builtin_type, "Integer"]]]]
        ])
      end
    end

  end
end
