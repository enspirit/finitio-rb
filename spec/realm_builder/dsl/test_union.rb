require 'spec_helper'
module Qrb
  describe RealmBuilder, "DSL#union" do

    let(:builder){ RealmBuilder.new }

    shared_examples_for "The Int|Float union type" do

      it{ should be_a(UnionType) }

      it 'should have the correct candidates' do
        subject.candidates.should eq([intType, floatType])
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
          builder.union([Integer, Float], 'MyUnion')
        }

        it_should_behave_like "The Int|Float union type"

        it 'should have the correct name' do
          subject.name.should eq("MyUnion")
        end
      end

      context 'when used with the standard signature and no name' do
        subject{
          builder.union([Integer, Float])
        }

        it_should_behave_like "The Int|Float union type"

        it 'should have the correct name' do
          subject.name.should eq("Integer|Float")
        end
      end

      context 'when used with a list of ruby classes' do
        subject{
          builder.union(Integer, Float)
        }

        it_should_behave_like "The Int|Float union type"

        it 'should have the correct name' do
          subject.name.should eq("Integer|Float")
        end
      end

      context 'when used with a list of types' do
        subject{
          builder.union(intType, floatType)
        }

        it_should_behave_like "The Int|Float union type"

        it 'should have the correct name' do
          subject.name.should eq("intType|floatType")
        end
      end

      context 'when used with a mix of both' do
        subject{
          builder.union(Integer, floatType)
        }

        it_should_behave_like "The Int|Float union type"

        it 'should have the correct name' do
          subject.name.should eq("Integer|floatType")
        end
      end

    end

    describe 'the ! version' do
      subject{
        builder.union!(Integer, Float)
      }

      it_should_behave_like "The Int|Float union type"

      it 'should be saved' do
        subject
        builder.realm['Integer|Float'].should be(subject)
      end
    end

  end
end
