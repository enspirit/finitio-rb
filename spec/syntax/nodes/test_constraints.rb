require 'spec_helper'
module Finitio
  describe Syntax, "constraints" do

    subject{
      Syntax.parse(input, root: "constraints")
    }

    let(:compiled){
      subject.compile("a")
    }

    let(:ast){
      subject.to_ast('a')
    }

    context 'a >= 10' do
      let(:input){ 'a >= 10' }

      it 'compiles to an Array' do
        expect(compiled).to be_a(Array)
        expect(compiled.size).to eq(1)
        expect(compiled.first).to be_a(Constraint)
      end

      it 'has the expected AST' do
        expect(ast).to eq([[
          :constraint,
          "default",
          [:fn, [:parameters, "a"], [:source, "a >= 10"]]
        ]])
      end
    end

    context 'foo: a >= 10' do
      let(:input){ 'foo: a >= 10' }

      it 'compiles to an Array' do
        expect(compiled).to be_a(Array)
        expect(compiled.size).to eq(1)
        expect(compiled.first).to be_a(Constraint)
        expect(compiled.map(&:name)).to eq([:foo])
      end

      it 'has the expected AST' do
        expect(ast).to eq([[
          :constraint,
          "foo",
          [:fn, [:parameters, "a"], [:source, "a >= 10"]]
        ]])
      end
    end

    context 'foo: a >= 10, bar: a <= 255' do
      let(:input){ 'foo: a >= 10, bar: a <= 255' }

      it 'compiles to an Array' do
        expect(compiled).to be_a(Array)
        expect(compiled.size).to eq(2)
        expect(compiled.first).to be_a(Constraint)
        expect(compiled.map(&:name)).to eq([:foo, :bar])
      end

      it 'has the expected AST' do
        expect(ast).to eq([
          [
            :constraint,
            "foo",
            [:fn, [:parameters, "a"], [:source, "a >= 10"]]
          ],
          [
            :constraint,
            "bar",
            [:fn, [:parameters, "a"], [:source, "a <= 255"]]
          ]
        ])
      end
    end

    context 'foo: a >= 10, foo: a <= 255' do
      let(:input){ 'foo: a >= 10, foo: a <= 255' }

      it 'raises an error' do
        expect{
          compiled
        }.to raise_error("Duplicate constraint name `foo`")
      end
    end

  end
end
