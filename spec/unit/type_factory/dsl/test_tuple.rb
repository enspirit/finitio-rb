require 'spec_helper'
module Qrb
  describe TypeFactory, "DSL#tuple" do

    let(:factory){ TypeFactory.new }

    let(:heading){
      Heading.new([ Attribute.new(:a, intType) ])
    }

    shared_examples_for "The Tuple[a: Int] type" do

      it{ should be_a(TupleType) }

      it 'should have the correct heading' do
        subject.heading.should eq(heading)
      end
    end

    before do
      subject
    end

    context 'when used with the standard signature' do
      subject{
        factory.tuple(heading, "MyTuple")
      }

      it_should_behave_like "The Tuple[a: Int] type"

      it 'should have the correct name' do
        subject.name.should eq("MyTuple")
      end
    end

    context 'when used with a hash and ruby classes' do
      subject{
        factory.tuple(a: Integer)
      }

      it_should_behave_like "The Tuple[a: Int] type"

      it 'should have the correct name' do
        subject.name.should eq("{a: Integer}")
      end
    end

    context 'when used with a hash and a name' do
      subject{
        factory.tuple({a: Integer}, "MyTuple")
      }

      it_should_behave_like "The Tuple[a: Int] type"

      it 'should have the correct name' do
        subject.name.should eq("MyTuple")
      end
    end

    context 'when used with a hash and types' do
      subject{
        factory.tuple(a: intType)
      }

      it_should_behave_like "The Tuple[a: Int] type"

      it 'should have the correct name' do
        subject.name.should eq("{a: intType}")
      end
    end

  end
end
