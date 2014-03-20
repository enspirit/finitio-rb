require 'spec_helper'
module Finitio
  describe Syntax, "attribute" do

    subject{
      Syntax.parse(input, root: "attribute")
    }

    describe 'compilation result' do
      let(:compiled){
        subject.compile(type_factory)
      }

      context 'a: .Integer' do
        let(:input){ 'a: .Integer' }

        it 'compiles to an Attribute' do
          compiled.should be_a(Attribute)
          compiled.name.should eq(:a)
          compiled.type.should be_a(BuiltinType)
          compiled.type.ruby_type.should be(Integer)
        end
      end
    end

    describe 'AST' do
      let(:ast){
        subject.to_ast
      }

      let(:input){ 'a: .Integer' }

      it{ ast.should eq([:attribute, "a", [:builtin_type, "Integer"]]) }
    end
    

  end
end
