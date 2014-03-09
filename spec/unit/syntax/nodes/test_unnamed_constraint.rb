require 'spec_helper'
module Qrb
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

      it 'compiles to an Hash' do
        compiled.should be_a(Hash)
      end

      it 'has expected keys' do
        compiled.keys.should eq([:predicate])
      end

      it 'should be the correct Proc' do
        compiled[:predicate].call(12).should be_true
        compiled[:predicate].call(9).should be_false
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
