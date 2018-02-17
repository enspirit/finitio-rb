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

      context 'a: .Integer, ...: .String' do
        let(:input){ 'a: .Integer, ...: .String' }

        it 'compiles to a Heading' do
          expect(compiled).to be_a(Heading)
          expect(compiled.to_name).to eq('a: Integer, ...: String')
        end
      end
    end

    describe "AST" do

      let(:ast){
        subject.to_ast
      }

      context 'when not using allow extra' do
        let(:input){ 'a: .Integer, b: .Float' }

        it{
          expect(ast).to eq([
            :heading,
            [ :attribute, "a", [:builtin_type, "Integer" ]],
            [ :attribute, "b", [:builtin_type, "Float" ]]
          ])
        }
      end

      context 'when specifying allow extra without type' do
        let(:input){ 'a: .Integer, b: .Float, ...' }

        it{
          expect(ast).to eq([
            :heading,
            [ :attribute, "a", [:builtin_type, "Integer" ]],
            [ :attribute, "b", [:builtin_type, "Float" ]],
            { allow_extra: true }
          ])
        }
      end

      context 'when specifying allow extra type' do
        let(:input){ 'a: .Integer, b: .Float, ...: .String' }

        it{
          expect(ast).to eq([
            :heading,
            [ :attribute, "a", [:builtin_type, "Integer" ]],
            [ :attribute, "b", [:builtin_type, "Float" ]],
            { allow_extra: [:builtin_type, "String"] }
          ])
        }
      end
    end
  end
end
