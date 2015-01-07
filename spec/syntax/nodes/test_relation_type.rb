require 'spec_helper'
module Finitio
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
          expect(compiled).to be_a(RelationType)
          expect(compiled.heading).to be_empty
        end
      end

      context '{{a: .Integer}}' do
        let(:input){ '{{a: .Integer}}' }

        it 'compiles to a RelationType' do
          expect(compiled).to be_a(RelationType)
          expect(compiled.heading.size).to eq(1)
        end
      end

      context '{{a: .Integer, b: .Float}}' do
        let(:input){ '{{a: .Integer, b: .Float}}' }

        it 'compiles to a RelationType' do
          expect(compiled).to be_a(RelationType)
          expect(compiled.heading.size).to eq(2)
        end
      end

      context '{{a: .Integer, b :? .Float}}' do
        let(:input){ '{{a: .Integer, b :? .Float}}' }

        it 'compiles to a MultiRelationType' do
          expect(compiled).to be_a(MultiRelationType)
          expect(compiled.heading.size).to eq(2)
        end
      end
    end

    describe "AST" do
      let(:ast){ subject.to_ast }

      context '{{a: .Integer}}' do
        let(:input){ '{{a: .Integer}}' }

        it{
          expect(ast).to eq([
            :relation_type,
            [
              :heading,
              [ :attribute, "a", [:builtin_type, "Integer" ]]
            ]
          ])
        }
      end

      context '{{a :? .Integer}}' do
        let(:input){ '{{a :? .Integer}}' }

        it{
          expect(ast).to eq([
            :multi_relation_type,
            [
              :heading,
              [ :attribute, "a", [:builtin_type, "Integer" ], false]
            ]
          ])
        }
      end
    end

  end
end
