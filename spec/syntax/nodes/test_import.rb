require 'spec_helper'
module Finitio
  describe Syntax, "import" do

    subject{
      Syntax.parse(input, root: "import")
    }

    let(:sys){
      Compilation.coerce(system, Path.dir/"test_import.rb")
    }

    let(:compiled){
      subject.compile(sys)
    }

    let(:ast){
      subject.to_ast
    }

    context 'with a stdlib import' do
      let(:input){ '@import finitio/data' }

      it 'compiles to an Import' do
        expect(compiled).to be(sys)
        expect(compiled.send(:imports).size).to eql(1)
      end

      it 'has the expected AST' do
        expect(ast).to eq([:import, "finitio/data"])
      end
    end

    context 'with a stdlib import' do
      let(:input){ '@import ./imported' }

      it 'compiles to an Import' do
        expect(compiled).to be(sys)
        expect(compiled.send(:imports).size).to eql(1)
      end

      it 'has the expected AST' do
        expect(ast).to eq([:import, "./imported"])
      end
    end

  end
end
