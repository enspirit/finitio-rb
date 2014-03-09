require 'spec_helper'
module Qrb
  describe Syntax, "ad_type" do

    subject{
      Syntax.parse(input, root: "ad_type")
    }

    let(:compiled){
      subject.compile(type_factory)
    }

    let(:ast){
      subject.to_ast
    }

    context 'One contract' do
      let(:input){ '.Color <rgb> {r: .Integer, g: .Integer, b: .Integer}' }

      it 'compiles to an AdType' do
        compiled.should be_a(AdType)
        compiled.ruby_type.should be(Color)
        compiled.contract_names.should eq([:rgb])
      end

      it 'should behave as expected' do
        compiled.dress(r: 138, g: 43, b: 226).should eq(blueviolet)
      end

      it 'has expected AST' do
        ast.should eq([
          :ad_type,
          "Color",
          [:contract,
            "rgb",
            [:tuple_type,
              [:heading,
                [:attribute, "r", [:builtin_type, "Integer"]],
                [:attribute, "g", [:builtin_type, "Integer"]],
                [:attribute, "b", [:builtin_type, "Integer"]]
              ]
            ]
          ]
        ])
      end
    end

    context 'Two contracts' do
      let(:input){
        <<-TYPE.strip
        .Color <rgb> {r: .Integer, g: .Integer, b: .Integer},
               <hex> .String
        TYPE
      }

      it 'compiles to an AdType' do
        compiled.should be_a(AdType)
        compiled.ruby_type.should be(Color)
        compiled.contract_names.should eq([:rgb, :hex])
      end

      it 'should behave as expected' do
        compiled.dress("#8A2BE2").should eq(blueviolet)
      end

      it 'has expected AST' do
        ast.should eq([
          :ad_type,
          "Color",
          [:contract,
            "rgb",
            [:tuple_type,
              [:heading,
                [:attribute, "r", [:builtin_type, "Integer"]],
                [:attribute, "g", [:builtin_type, "Integer"]],
                [:attribute, "b", [:builtin_type, "Integer"]]
              ]
            ]
          ],
          [:contract,
            "hex",
            [:builtin_type, "String"]
          ]
        ])
      end
    end

    context 'No ruby class' do
      let(:input){ '<as> {r: .Integer}' }

      it 'compiles to an AdType' do
        compiled.should be_a(AdType)
        compiled.ruby_type.should be_nil
        compiled.contract_names.should eq([:as])
      end

      it 'should behave as expected' do
        compiled.dress(r: 12).should eq(r: 12)
        ->{
          compiled.dress("foo")
        }.should raise_error(TypeError)
      end

      it 'has expected AST' do
        ast.should eq([
          :ad_type,
          nil,
          [:contract,
            "as",
            [:tuple_type,
              [:heading,
                [:attribute, "r", [:builtin_type, "Integer"]],
              ]
            ]
          ]
        ])
      end
    end

    context 'Duplicate contract name' do
      let(:input){ '.Color <rgb> {r: .Integer}, <rgb> .String' }

      it 'raises an error' do
        ->{
          compiled
        }.should raise_error(Error, "Duplicate contract name `rgb`")
      end
    end

    context 'A contract with explicit converters' do
      let(:input){ '.DateTime <iso> .String \( s | DateTime.parse(s) ) \( d | d.to_s )' }

      it 'compiles to an AdType' do
        compiled.should be_a(AdType)
        compiled.ruby_type.should be(DateTime)
        compiled.contract_names.should eq([:iso])
      end

      it 'should behave as expected' do
        compiled.dress("2014-01-19T12:00").should be_a(DateTime)
      end

      it 'should hide errors' do
        err = compiled.dress("foo") rescue $!
        err.should be_a(TypeError)
        err.message.should eq("Invalid value `foo` for DateTime")
      end

      it 'has expected AST' do
        ast.should eq([
          :ad_type,
          "DateTime",
          [:contract,
            "iso",
            [:builtin_type, "String"],
            [:inline_pair,
              [:fn, [:parameters, "s"], [:source, "DateTime.parse(s)"]],
              [:fn, [:parameters, "d"], [:source, "d.to_s"]],
            ]
          ]
        ])
      end
    end

  end
end
