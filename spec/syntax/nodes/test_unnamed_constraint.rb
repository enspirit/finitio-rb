require 'spec_helper'
module Finitio
  describe Syntax, "unnamed_constraint" do

    subject{
      Syntax.parse(input, root: "unnamed_constraint")
    }

    let(:compiled){
      subject.compile("a")
    }

    let(:ast){
      subject.to_ast("a")
    }

    context 'a >= 10' do
      let(:input){ 'a >= 10' }

      it 'compiles to an Constraint' do
        expect(compiled).to be_a(Constraint)
      end

      it 'is anonymous' do
        expect(compiled).to be_anonymous
      end

      it 'should be the correct Proc' do
        expect(compiled.===(12)).to eq(true)
        expect(compiled.===(9)).to eq(false)
      end

      it 'has the expected AST' do
        expect(ast).to eq([
          :constraint,
          "default",
          [:fn, [:parameters, "a"], [:source, "a >= 10"]]
        ])
      end
    end

  end
end
