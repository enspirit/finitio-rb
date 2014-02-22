require 'spec_helper'
module Qrb
  describe Syntax, "constraint_def" do

    subject{
      Syntax.parse(input, root: "constraint_def")
    }

    let(:compiled){
      subject.compile(type_factory)
    }

    context '(i | i >= 0)' do
      let(:input){ '(i | i >= 0)' }

      it 'compiles to an Hash' do
        compiled.should be_a(Hash)
      end

      it 'compiled to the correct proc' do
        compiled[:predicate].call(12).should be_true
        compiled[:predicate].call(-12).should be_false
      end
    end

  end
end
