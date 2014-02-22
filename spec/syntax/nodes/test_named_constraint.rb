require 'spec_helper'
module Qrb
  describe Syntax, "named_constraint" do

    subject{
      Syntax.parse(input, root: "named_constraint")
    }

    let(:compiled){
      subject.compile("a")
    }

    context 'a >= 10' do
      let(:input){ 'foo: a >= 10' }

      it 'compiles to an Hash' do
        compiled.should be_a(Hash)
      end

      it 'has expected keys' do
        compiled.keys.should eq([:foo])
      end

      it 'should be the correct Proc' do
        compiled[:foo].call(12).should be_true
        compiled[:foo].call(9).should be_false
      end
    end

  end
end
