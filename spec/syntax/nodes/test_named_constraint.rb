require 'spec_helper'
module Finitio
  describe Syntax, "named_constraint" do

    subject{
      Syntax.parse(input, root: "named_constraint")
    }

    let(:compiled){
      subject.compile("a")
    }

    let(:ast){
      subject.to_ast('a')
    }

    context 'foo: a >= 10' do
      let(:input){ 'foo: a >= 10' }

      it 'compiles to a Constraint' do
        expect(compiled).to be_a(Constraint)
      end

      it 'has expected name' do
        expect(compiled.name).to eq(:foo)
      end

      it 'should be the correct Proc' do
        expect(compiled.===(12)).to eq(true)
        expect(compiled.===(9)).to eq(false)
      end

      it 'has the expected AST' do
        expect(ast).to eq([
          :constraint,
          "foo",
          [:fn, [:parameters, "a"], [:source, "a >= 10"]]
        ])
      end
    end

  end
end
