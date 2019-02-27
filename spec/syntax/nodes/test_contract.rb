require 'spec_helper'
module Finitio
  describe Syntax, "contract" do

    subject{
      Syntax.parse(input, root: "contract")
    }

    let(:ast){
      subject.to_ast
    }

    context 'No converter and a class' do
      let(:input){ '<rgb> {r: .Integer, g: .Integer, b: .Integer}' }

      let(:compiled){
        subject.compile(type_factory, Color)
      }

      it 'compiles to the expected Contract' do
        expect(compiled).to be_a(Contract)
        expect(compiled.name).to eq(:rgb)
        expect(compiled.infotype).to be_a(TupleType)
        expect(compiled.dresser).to be_a(Method)
        expect(compiled.undresser).to be_a(Proc)
      end

      it 'has expected AST' do
        expect(ast).to eq([
          :contract,
          "rgb",
          [:tuple_type,
            [:heading,
              [:attribute, "r", [:builtin_type, "Integer"]],
              [:attribute, "g", [:builtin_type, "Integer"]],
              [:attribute, "b", [:builtin_type, "Integer"]]
            ]
          ]
        ])
      end
    end

    context 'No converter and no class' do
      let(:input){ '<rgb> {r: .Integer, g: .Integer, b: .Integer}' }

      let(:compiled){
        subject.compile(type_factory, nil)
      }

      it 'compiles to the expected Contract' do
        expect(compiled).to be_a(Contract)
        expect(compiled.name).to eq(:rgb)
        expect(compiled.infotype).to be_a(TupleType)
        expect(compiled.dresser).to be(Finitio::IDENTITY)
        expect(compiled.undresser).to be(Finitio::IDENTITY)
      end

      it 'has expected AST' do
        expect(ast).to eq([
          :contract,
          "rgb",
          [:tuple_type,
            [:heading,
              [:attribute, "r", [:builtin_type, "Integer"]],
              [:attribute, "g", [:builtin_type, "Integer"]],
              [:attribute, "b", [:builtin_type, "Integer"]]
            ]
          ]
        ])
      end
    end

    context 'A contract with explicit converters' do
      let(:input){ '<iso> .String \( s | DateTime.parse(s) ) \( d | d.to_s )' }

      let(:compiled){
        subject.compile(type_factory, nil)
      }

      it 'compiles to the expected Contract' do
        expect(compiled).to be_a(Contract)
        expect(compiled.name).to eq(:iso)
        expect(compiled.infotype).to be_a(BuiltinType)
        expect(compiled.dresser).to be_a(Proc)
        expect(compiled.undresser).to be_a(Proc)
      end

      it 'has expected AST' do
        expect(ast).to eq([
          :contract,
          "iso",
          [:builtin_type, "String"],
          [:inline_pair,
            [:fn, [:parameters, "s"], [:source, "DateTime.parse(s)"]],
            [:fn, [:parameters, "d"], [:source, "d.to_s"]]
          ]
        ])
      end

      it 'is equal to itself by code' do
        j = Syntax.parse(input, root: "contract").compile(type_factory, nil)
        expect(j).to eql(compiled)
      end
    end

    context 'A contract with external dressers' do
      let(:input){ '<iso> .String .ExternalContract' }

      let(:compiled){
        subject.compile(type_factory, nil)
      }

      it 'compiles to the expected Contract' do
        expect(compiled).to be_a(Contract)
        expect(compiled.name).to eq(:iso)
        expect(compiled.infotype).to be_a(BuiltinType)
        expect(compiled.dresser).to be_a(Method)
        expect(compiled.undresser).to be_a(Method)
      end

      it 'has expected AST' do
        expect(ast).to eq([
          :contract,
          "iso",
          [:builtin_type, "String"],
          [:external_pair, "ExternalContract"]
        ])
      end
    end

  end
end
