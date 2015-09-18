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

        it 'compiles to an mandatory Attribute' do
          expect(compiled).to be_a(Attribute)
          expect(compiled.name).to eq(:a)
          expect(compiled.type).to be_a(BuiltinType)
          expect(compiled.type.ruby_type).to be(Integer)
          expect(compiled).to be_required
        end
      end

      context 'a :? .Integer' do
        let(:input){ 'a :? .Integer' }

        it 'compiles to an optional Attribute' do
          expect(compiled).to be_a(Attribute)
          expect(compiled.name).to eq(:a)
          expect(compiled.type).to be_a(BuiltinType)
          expect(compiled.type.ruby_type).to be(Integer)
          expect(compiled).not_to be_required
        end
      end
    end

    describe 'AST' do
      let(:ast){
        subject.to_ast
      }

      context 'a: .Integer' do
        let(:input){ 'a: .Integer' }

        it{ expect(ast).to eq([:attribute, "a", [:builtin_type, "Integer"]]) }
      end

      context 'a :? .Integer' do
        let(:input){ 'a :? .Integer' }

        it{ expect(ast).to eq([:attribute, "a", [:builtin_type, "Integer"], false]) }
      end

      context '_ : .Integer' do
        let(:input){ '_ : .Integer' }

        it{ expect(ast).to eq([:attribute, "_", [:builtin_type, "Integer"]]) }
      end

    end
    
  end
end
