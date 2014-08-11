require 'spec_helper'
module Finitio
  describe Syntax, "expression" do

    subject{
      Syntax.parse(input, root: "expression")
    }

    let(:compiled){
      subject.compile("a")
    }

    context 'a >= 10' do
      let(:input){ 'a >= 10' }

      it 'compiles to an Proc' do
        compiled.should be_a(Proc)
      end

      it 'should be the correct Proc' do
        compiled.call(12).should be_true
        compiled.call(9).should be_false
      end
    end

    context '(a >= 10)' do
      let(:input){ '(a >= 10)' }

      it 'compiles to an Proc' do
        compiled.should be_a(Proc)
      end
    end

    context 'acall(a)' do
      let(:input){ 'acall(a)' }

      it 'compiles to an Proc' do
        compiled.should be_a(Proc)
      end
    end

    context 's =~ /^(test)$/' do
      let(:input){ 's =~ /^(test)$/' }

      it 'compiles to an Proc' do
        compiled.should be_a(Proc)
      end
    end

  end
end
