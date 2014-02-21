require 'spec_helper'
module Qrb
  describe RealmBuilder, "DSL#seq" do

    let(:builder){ RealmBuilder.new }

    shared_examples_for "The Seq[Int] type" do

      it{ should be_a(SeqType) }

      it 'should have the correct element type' do
        subject.elm_type.should eq(intType)
      end
    end

    describe 'the normal version' do

      before do
        subject
        # it should not be saved
        builder.realm[subject.name].should be_nil
      end

      context 'when used with a ruby class' do
        subject{
          builder.seq(Integer)
        }

        it_should_behave_like "The Seq[Int] type"

        it 'should have the correct name' do
          subject.name.should eq("[Integer]")
        end
      end

      context 'when used with a type' do
        subject{
          builder.seq(intType)
        }

        it_should_behave_like "The Seq[Int] type"

        it 'should have the correct name' do
          subject.name.should eq("[intType]")
        end
      end

      context 'when used with an explicit name' do
        subject{
          builder.seq(intType, "MySeq")
        }

        it_should_behave_like "The Seq[Int] type"

        it 'should have the correct name' do
          subject.name.should eq("MySeq")
        end
      end

    end

    describe 'the ! version' do
      subject{
        builder.seq!(Integer)
      }

      it_should_behave_like "The Seq[Int] type"

      it 'should be saved' do
        subject
        builder.realm['[Integer]'].should be(subject)
      end
    end

  end
end
