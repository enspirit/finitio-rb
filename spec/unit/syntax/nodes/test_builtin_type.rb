require 'spec_helper'
module Finitio
  describe Syntax, "builtin_type" do

    subject{
      Syntax.parse(source, root: "builtin_type")
    }

    describe "compilation result" do
      let(:compiled){
        subject.compile(type_factory)
      }

      context 'when an unqualified class name' do
        let(:source){ ".Integer" }

        it 'compiles to a BuiltinType' do
          compiled.should be_a(BuiltinType)
          compiled.ruby_type.should be(Integer)
        end
      end

      context 'when a qualified class name' do
        let(:source){ ".Finitio::Type" }

        it 'compiles to a BuiltinType' do
          compiled.should be_a(BuiltinType)
          compiled.ruby_type.should be(::Finitio::Type)
        end
      end
    end

    describe "AST" do
      let(:source){ ".Finitio::Type" }

      let(:ast){
        subject.to_ast
      }

      it{ ast.should eq([:builtin_type, "Finitio::Type"]) }
    end

  end
end
