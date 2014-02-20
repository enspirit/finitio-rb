require 'spec_helper'
module Qrb
  describe UserType, 'up' do

    let(:type){
      UserType.new({intType   => ->(i){ Foo.new(i) },
                    floatType => ->(f){ Bar.new(f) }}, "userType")
    }

    subject{
      type.up(arg)
    }

    context 'with an integer' do
      let(:arg){ 12 }

      it{ should be_a(Foo) }

      it 'should pass the integer' do
        subject.args.should eq([12])
      end
    end

    context 'with a float' do
      let(:arg){ 12.0 }

      it{ should be_a(Bar) }

      it 'should pass the float' do
        subject.args.should eq([12.0])
      end
    end

    context 'with an unrecognized' do
      let(:arg){ "foo" }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(UpError, "Invalid value `foo` for userType")
      end
    end

  end
end