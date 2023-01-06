require 'spec_helper'
module Finitio
  describe Syntax, '.compile' do

    subject do
      Syntax.compile(source)
    end

    context 'with a single main type' do
      let(:source){
        <<-EOF.strip
        .Integer
        EOF
      }

      it{ should be_a(System) }

      it 'should have main type' do
        expect(subject.main).to be_a(BuiltinType)
        expect(subject['Main']).to be(subject.main)
      end
    end

    context 'with a single main alias type' do
      let(:source){
        <<-EOF.strip
        Int = .Integer
        Int
        EOF
      }

      it{ should be_a(System) }

      it 'should have main type' do
        expect(subject.main).to be_a(AliasType)
        expect(subject['Main']).to be(subject.main)
      end
    end

    context 'with lots of proxies to resolve' do
      let(:source){
        <<-EOF.strip
        Deep = .String
        Obj = { i: Deep }
        Objs = [Obj]
        EOF
      }

      it{ should be_a(System) }

      it 'should work fine' do
        expect {
          subject['Objs'].dress([{i: "hello"}])
        }.not_to raise_error
      end
    end

    context 'with a recursive def' do
      let(:source){
        <<-EOF.strip
        S = .String
        NodeLabel = S
        Tree = { label: NodeLabel, children: [Tree] }
        EOF
      }

      it{ should be_a(System) }

      it 'should work ine' do
        expect {
          subject['Tree'].dress({ label: "Root", children: [
            { label: "Child1", children: [] },
            { label: "Child2", children: [] }
          ]})
        }.not_to raise_error
      end
    end

    context 'with AD types' do
      let(:source){
        <<-EOF.strip
        Int = .Integer
        Byte = Int(i | i>0)
        Color = .Color <rgb> { r: Byte, g: Byte, b: Byte }
        Colors = [Color]
        EOF
      }

      it{ should be_a(System) }

      it 'should work fine' do
        got = subject['Colors'].dress([{ r: 10, g: 15, b: 20 }])
        expect(got.first).to be_a(Color)
      end
    end

    context 'with AD types that make forward references' do
      let(:source){
        <<-EOF.strip
        Colors = [Color]
        Color = .Color <rgb> { r: Byte, g: Byte, b: Byte }
        Byte = Int(i | i>0)
        Int = .Integer
        EOF
      }

      it{ should be_a(System) }

      it 'should work fine' do
        got = subject['Colors'].dress([{ r: 10, g: 15, b: 20 }])
        expect(got.first).to be_a(Color)
      end
    end

  end
end
