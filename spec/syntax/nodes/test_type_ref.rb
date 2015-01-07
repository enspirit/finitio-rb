require 'spec_helper'
module Finitio
  describe Syntax, "type_ref" do

    subject{
      Syntax.parse(input, root: "type_ref")
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

    before do
      sys.add_type(BuiltinType.new(Integer, "Int"))
    end

    let(:input){ 'Int' }

    it 'compiles to a the BuiltinType' do
      expect(compiled).to be_a(BuiltinType)
      expect(compiled.name).to eq("Int")
    end

    it 'has the expected AST' do
      expect(ast).to eq([:type_ref, "Int"])
    end

  end
end
