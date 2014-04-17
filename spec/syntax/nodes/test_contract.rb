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
        compiled.should be_a(Contract)
        compiled.name.should eq(:rgb)
        compiled.infotype.should be_a(TupleType)
        compiled.dresser.should be_a(Method)
        compiled.undresser.should be_a(Proc)
      end

      it 'has expected AST' do
        ast.should eq([
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
        compiled.should be_a(Contract)
        compiled.name.should eq(:rgb)
        compiled.infotype.should be_a(TupleType)
        compiled.dresser.should be(Finitio::IDENTITY)
        compiled.undresser.should be(Finitio::IDENTITY)
      end

      it 'has expected AST' do
        ast.should eq([
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
        compiled.should be_a(Contract)
        compiled.name.should eq(:iso)
        compiled.infotype.should be_a(BuiltinType)
        compiled.dresser.should be_a(Proc)
        compiled.undresser.should be_a(Proc)
      end

      it 'has expected AST' do
        ast.should eq([
          :contract,
          "iso",
          [:builtin_type, "String"],
          [:inline_pair,
            [:fn, [:parameters, "s"], [:source, "DateTime.parse(s)"]],
            [:fn, [:parameters, "d"], [:source, "d.to_s"]]
          ]
        ])
      end
    end

    context 'A contract with external dressers' do
      let(:input){ '<iso> .String .ExternalContract' }

      let(:compiled){
        subject.compile(type_factory, nil)
      }

      it 'compiles to the expected Contract' do
        compiled.should be_a(Contract)
        compiled.name.should eq(:iso)
        compiled.infotype.should be_a(BuiltinType)
        compiled.dresser.should be_a(Method)
        compiled.undresser.should be_a(Method)
      end

      it 'has expected AST' do
        ast.should eq([
          :contract,
          "iso",
          [:builtin_type, "String"],
          [:external_pair, "ExternalContract"]
        ])
      end
    end

  end
end
