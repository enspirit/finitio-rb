require 'spec_helper'
module Qrb
  describe Syntax, "constraint_def" do

    subject{
      Syntax.parse(input, root: "constraint_def")
    }

    let(:compiled){
      subject.compile(realm_builder)
    }

    context '(i | i >= 0)' do
      let(:input){ '(i | i >= 0)' }

      it 'compiles to an Proc' do
        compiled.should be_a(Proc)
      end

      it 'compiled to the correct proc' do
        compiled.call(12).should be_true
        compiled.call(-12).should be_false
      end
    end

  end
end
