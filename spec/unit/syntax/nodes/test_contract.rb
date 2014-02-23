require 'spec_helper'
module Qrb
  describe Syntax, "contract" do

    subject{
      Syntax.parse(input, root: "contract")
    }

    let(:contract){
      compiled.values.first
    }

    context 'No converter and a class' do
      let(:input){ '<rgb> {r: .Integer, g: .Integer, b: .Integer}' }

      let(:compiled){
        subject.compile(type_factory, Color)
      }

      it 'compiles to the expected Hash' do
        compiled.should be_a(Hash)
        compiled.keys.should eq([:rgb])
        contract.should be_a(Array)
        contract.first.should be_a(TupleType)
        contract.last.should be_a(Method)
      end
    end

    context 'No converter and no class' do
      let(:input){ '<rgb> {r: .Integer, g: .Integer, b: .Integer}' }

      let(:compiled){
        subject.compile(type_factory, nil)
      }

      it 'compiles to the expected Hash' do
        compiled.should be_a(Hash)
        compiled.keys.should eq([:rgb])
        contract.should be_a(Array)
        contract.first.should be_a(TupleType)
        contract.last.should be(Qrb::IDENTITY)
      end
    end

    context 'A contract with explicit converters' do
      let(:input){ '<iso> .String \( s | DateTime.parse(s) ) \( d | d.to_s )' }

      let(:compiled){
        subject.compile(type_factory, nil)
      }

      it 'compiles to the expected Hash' do
        compiled.should be_a(Hash)
        compiled.keys.should eq([:iso])
        contract.should be_a(Array)
        contract.first.should be_a(BuiltinType)
        contract.last.should be_a(Proc)
      end
    end

  end
end
