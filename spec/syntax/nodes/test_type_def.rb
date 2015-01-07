require 'spec_helper'
module Finitio
  describe Syntax, "type_def" do

    subject{
      Syntax.parse(input, root: "type_def")
    }

    let(:sys){
      system
    }

    let(:compiled){
      subject.compile(sys)
    }

    let(:ast){
      subject.to_ast
    }

    context 'when referening an anonymous type' do
      let(:input){ 'Int = .Integer' }

      it 'add the type to the system' do
        compiled
        expect(sys["Int"]).to be_a(BuiltinType)
      end

      it 'has the expected AST' do
        expect(ast).to eq([:type_def, "Int", [:builtin_type, "Integer"]])
      end
    end

    context 'when making an alias' do
      let(:legacy) {
        BuiltinType.new(Integer, "Int")
      }

      let(:input){ 'Alias = Int' }

      before do
        sys.add_type(legacy)
      end

      it 'add the type to the system' do
        compiled
        expect(sys["Alias"]).to be_a(AliasType)
        expect(sys["Alias"]).to eq(legacy)
      end

      it 'has the expected AST' do
        expect(ast).to eq([:type_def, "Alias", [:type_ref, "Int"]])
      end
    end

  end
end
