require 'spec_helper'
module Finitio
  describe Syntax, "constraint_def" do

    subject{
      Syntax.parse(input, root: "constraint_def")
    }

    let(:compiled){
      subject.compile(type_factory)
    }

    let(:ast){
      subject.to_ast
    }

    context '(i | i >= 0)' do
      let(:input){ '(i | i >= 0)' }

      it 'compiles to an Array' do
        compiled.should be_a(Array)
      end

      it 'has the expected AST' do
        ast.should eq([
          [
            :constraint,
            "default",
            [:fn, [:parameters, "i"], [:source, "i >= 0"]]
          ]
        ])
      end
    end

  end
end
