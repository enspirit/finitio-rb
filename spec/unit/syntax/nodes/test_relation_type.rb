require 'spec_helper'
module Qrb
  describe Syntax, "relation_type" do

    subject{
      Syntax.parse(input, root: "relation_type")
    }

    describe "compilation result" do
      let(:compiled){
        subject.compile(type_factory)
      }

      context 'empty heading' do
        let(:input){ '{{ }}' }

        it 'compiles to a RelationType' do
          compiled.should be_a(RelationType)
          compiled.heading.should be_empty
        end
      end

      context '{{a: .Integer}}' do
        let(:input){ '{{a: .Integer}}' }

        it 'compiles to a RelationType' do
          compiled.should be_a(RelationType)
          compiled.heading.size.should eq(1)
        end
      end

      context '{{a: .Integer, b: .Float}}' do
        let(:input){ '{{a: .Integer, b: .Float}}' }

        it 'compiles to a RelationType' do
          compiled.should be_a(RelationType)
          compiled.heading.size.should eq(2)
        end
      end
    end

    describe "AST" do
      let(:input){ '{{a: .Integer}}' }

      let(:ast){ subject.to_ast }

      it{
        ast.should eq([
          :relation_type,
          [
            :heading,
            [ :attribute, "a", [:builtin_type, "Integer" ]]
          ]
        ])
      }
    end

  end
end
