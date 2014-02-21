require 'spec_helper'
module Qrb
  describe RealmBuilder, "DSL#tuple" do

    let(:builder){ RealmBuilder.new }

    let(:heading){
      Heading.new([ Attribute.new(:a, intType) ])
    }

    shared_examples_for "The Tuple[a: Int] type" do

      it{ should be_a(TupleType) }

      it 'should have the correct heading' do
        subject.heading.should eq(heading)
      end
    end

    describe 'the normal version' do

      before do
        subject
        # it should not be saved
        builder.realm[subject.name].should be_nil
      end

      context 'when used with the standard signature' do
        subject{
          builder.tuple(heading, "MyTuple")
        }

        it_should_behave_like "The Tuple[a: Int] type"

        it 'should have the correct name' do
          subject.name.should eq("MyTuple")
        end
      end

      context 'when used with a hash and ruby classes' do
        subject{
          builder.tuple(a: Integer)
        }

        it_should_behave_like "The Tuple[a: Int] type"

        it 'should have the correct name' do
          subject.name.should eq("{a: Integer}")
        end
      end

      context 'when used with a hash and a name' do
        subject{
          builder.tuple({a: Integer}, "MyTuple")
        }

        it_should_behave_like "The Tuple[a: Int] type"

        it 'should have the correct name' do
          subject.name.should eq("MyTuple")
        end
      end

      context 'when used with a hash and types' do
        subject{
          builder.tuple(a: intType)
        }

        it_should_behave_like "The Tuple[a: Int] type"

        it 'should have the correct name' do
          subject.name.should eq("{a: intType}")
        end
      end
    end

    describe 'the ! version' do
      subject{
        builder.tuple!(a: Integer)
      }

      it_should_behave_like "The Tuple[a: Int] type"

      it 'should be saved' do
        subject
        builder.realm['{a: Integer}'].should be(subject)
      end
    end

  end
end
