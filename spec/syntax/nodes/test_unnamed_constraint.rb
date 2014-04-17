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
        compiled.should be_a(Constraint)
      end

      it 'is anonymous' do
        compiled.should be_anonymous
      end

      it 'should be the correct Proc' do
        compiled.===(12).should be_true
        compiled.===(9).should be_false
      end

      it 'has the expected AST' do
        ast.should eq([
          :constraint,
          "default",
          [:fn, [:parameters, "a"], [:source, "a >= 10"]]
        ])
      end
    end

  end
end
