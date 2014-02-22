require 'spec_helper'
module Qrb
  describe TypeFactory, "DSL#set" do

    let(:factory){ TypeFactory.new }

    shared_examples_for "The Set[Int] type" do

      it{ should be_a(SetType) }

      it 'should have the correct element type' do
        subject.elm_type.should eq(intType)
      end
    end

    before do
      subject
    end

    context 'when used with a ruby class' do
      subject{
        factory.set(Integer)
      }

      it_should_behave_like "The Set[Int] type"

      it 'should have the correct name' do
        subject.name.should eq("{Integer}")
      end
    end

    context 'when used with a type' do
      subject{
        factory.set(intType)
      }

      it_should_behave_like "The Set[Int] type"

      it 'should have the correct name' do
        subject.name.should eq("{intType}")
      end
    end

    context 'when used with an explicit name' do
      subject{
        factory.set(intType, "MySet")
      }

      it_should_behave_like "The Set[Int] type"

      it 'should have the correct name' do
        subject.name.should eq("MySet")
      end
    end

  end
end
