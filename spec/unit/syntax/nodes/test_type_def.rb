require 'spec_helper'
module Qrb
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

    let(:input){ 'Int = .Integer' }

    it 'add the type to the system' do
      compiled
      sys["Int"].should be_a(BuiltinType)
    end

    it 'has the expected AST' do
      ast.should eq([:type_def, "Int", [:builtin_type, "Integer"]])
    end

  end
end
