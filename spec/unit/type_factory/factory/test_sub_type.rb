require 'spec_helper'
module Qrb
  describe TypeFactory, "Factory#sub_type" do

    let(:factory){ TypeFactory.new }

    shared_examples_for "The 1..10 type" do

      it{ should be_a(SubType) }

      it 'should have the BuiltinType(Fixnum) super type' do
        subject.super_type.should be_a(BuiltinType)
        subject.super_type.ruby_type.should be(Fixnum)
      end

      it 'should have the correct constraint' do
        subject.up(10).should eq(10)
        ->{ subject.up(-12) }.should raise_error(UpError)
        ->{ subject.up(12) }.should raise_error(UpError)
      end
    end

    context 'when use with a ruby class and a block' do
      subject{
        factory.type(Fixnum){|i| i>=0 and i<=10 }
      }

      it_should_behave_like "The 1..10 type"
    end

    context 'when use with a a range' do
      subject{
        factory.type(1..10)
      }

      it_should_behave_like "The 1..10 type"
    end

    context 'when use with a regexp' do
      subject{
        factory.type(/[a-z]+/)
      }

      it { should be_a(SubType) }

      it 'should have the correct constraint' do
        subject.up('abc').should eq('abc')
        ->{ subject.up('123') }.should raise_error(UpError)
      end
    end

  end
end
