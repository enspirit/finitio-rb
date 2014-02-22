require 'spec_helper'
module Qrb
  describe Syntax, "sub_type" do

    subject{
      Syntax.parse(input, root: "sub_type")
    }

    let(:compiled){
      subject.compile(type_factory)
    }

    context '.Integer( i | i >= 0 )' do
      let(:input){ '.Integer( i | i >= 0 )' }

      it 'compiles to a SubType' do
        compiled.should be_a(SubType)
        compiled.super_type.should be_a(BuiltinType)
        compiled.super_type.ruby_type.should be(Integer)
      end
    end

    context '.Integer( i | positive: i >= 0 )' do
      let(:input){ '.Integer( i | positive: i >= 0 )' }

      it 'compiles to a SubType' do
        compiled.should be_a(SubType)
        compiled.super_type.should be_a(BuiltinType)
        compiled.super_type.ruby_type.should be(Integer)
      end

      it 'has the correct constraints' do
        compiled.constraints.keys.should eq([:positive])
      end
    end

    context '.Integer( i | positive: i >= 0, ... )' do
      let(:input){ '.Integer( i | positive: i >= 0, small: i <= 255 )' }

      it 'compiles to a SubType' do
        compiled.should be_a(SubType)
        compiled.super_type.should be_a(BuiltinType)
        compiled.super_type.ruby_type.should be(Integer)
      end

      it 'has the correct constraints' do
        compiled.constraints.keys.should eq([:positive, :small])
      end
    end

  end
end
