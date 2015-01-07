require 'spec_helper'
module Finitio
  describe TypeFactory, "Factory#sub_type" do

    let(:factory){ TypeFactory.new }

    shared_examples_for "The 1..10 type" do

      it{ should be_a(SubType) }

      it 'should have the BuiltinType(Fixnum) super type' do
        expect(subject.super_type).to be_a(BuiltinType)
        expect(subject.super_type.ruby_type).to be(Fixnum)
      end

      it 'should have the correct constraint' do
        expect(subject.dress(10)).to eq(10)
        expect{ subject.dress(-12) }.to raise_error(TypeError)
        expect{ subject.dress(12) }.to raise_error(TypeError)
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
        expect(subject.dress('abc')).to eq('abc')
        expect{ subject.dress('123') }.to raise_error(TypeError)
      end
    end

  end
end
