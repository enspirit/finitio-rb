require 'spec_helper'
module Finitio
  describe Syntax, "heading" do

    subject{
      Syntax.parse(input, root: "heading")
    }

    describe "compilation result" do
      let(:compiled){
        subject.compile(type_factory)
      }

      context 'empty heading' do
        let(:input){ '  ' }

        it 'compiles to a Heading' do
          expect(compiled).to be_a(Heading)
          expect(compiled.to_name).to eq('')
        end
      end

      context 'a: .Integer' do
        let(:input){ 'a: .Integer' }

        it 'compiles to a Heading' do
          expect(compiled).to be_a(Heading)
          expect(compiled.to_name).to eq('a: Integer')
        end
      end

      context 'a: .Integer, b: .Float' do
        let(:input){ 'a: .Integer, b: .Float' }

        it 'compiles to a Heading' do
          expect(compiled).to be_a(Heading)
          expect(compiled.to_name).to eq('a: Integer, b: Float')
        end
      end

      context 'a: .Integer, b :? .Float' do
        let(:input){ 'a: .Integer, b :? .Float' }

        it 'compiles to a Heading' do
          expect(compiled).to be_a(Heading)
          expect(compiled.to_name).to eq('a: Integer, b :? Float')
        end
      end

      context 'a: .Integer, ...' do
        let(:input){ 'a: .Integer, ...' }

        it 'compiles to a Heading' do
          expect(compiled).to be_a(Heading)
          expect(compiled.to_name).to eq('a: Integer, ...')
        end
      end
    end

    describe "AST" do
      let(:input){ 'a: .Integer, b: .Float' }

      let(:ast){
        subject.to_ast
      }

      it{
        expect(ast).to eq([
          :heading,
          [ :attribute, "a", [:builtin_type, "Integer" ]],
          [ :attribute, "b", [:builtin_type, "Float" ]]
        ])
      }
    end
  end
end
