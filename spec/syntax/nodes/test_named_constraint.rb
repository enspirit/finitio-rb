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
        compiled.should be_a(Constraint)
      end

      it 'has expected name' do
        compiled.name.should eq(:foo)
      end

      it 'should be the correct Proc' do
        compiled.===(12).should be_true
        compiled.===(9).should be_false
      end

      it 'has the expected AST' do
        ast.should eq([
          :constraint,
          "foo",
          [:fn, [:parameters, "a"], [:source, "a >= 10"]]
        ])
      end
    end

  end
end
