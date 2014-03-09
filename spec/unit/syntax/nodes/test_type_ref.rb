require 'spec_helper'
module Qrb
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
      compiled.should be_a(BuiltinType)
      compiled.name.should eq("Int")
    end

    it 'has the expected AST' do
      ast.should eq([:type_ref, "Int"])
    end

  end
end
