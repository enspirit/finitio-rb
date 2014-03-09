require 'spec_helper'
module Qrb
  describe Syntax, "any_type" do

    subject{
      Syntax.parse(source, root: "any_type")
    }

    let(:source){ "." }

    describe "compilation result" do
      let(:compiled){
        subject.compile(type_factory)
      }

      it 'compiles to an AnyType' do
        compiled.should be_a(AnyType)
      end
    end

    describe "AST" do
      let(:ast){
        subject.to_ast
      }

      it{ ast.should eq([:any_type]) }
    end

  end
end
