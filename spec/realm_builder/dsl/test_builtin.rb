require 'spec_helper'
module Qrb
  describe RealmBuilder, "DSL#builtin" do

    let(:builder){ RealmBuilder.new }

    shared_examples_for "The Integer builtin type" do

      it{ should be_a(BuiltinType) }

      it 'should have the correct ruby type' do
        subject.ruby_type.should be(Integer)
      end
    end

    describe 'the normal version' do

      before do
        subject
        # it should not be saved
        builder.realm[subject.name].should be_nil
      end

      context 'when used with a ruby class and no name' do
        subject{
          builder.builtin(Integer)
        }

        it_should_behave_like "The Integer builtin type"

        it 'should have the correct name' do
          subject.name.should eq("Integer")
        end
      end

      context 'when used with a ruby class and a name' do
        subject{
          builder.builtin(Integer, "Int")
        }

        it_should_behave_like "The Integer builtin type"

        it 'should have the correct name' do
          subject.name.should eq("Int")
        end
      end

    end

    describe 'the ! version' do
      subject{
        builder.builtin!(Integer, "Int")
      }

      it_should_behave_like "The Integer builtin type"

      it 'should be saved' do
        subject
        builder.realm['Int'].should be(subject)
      end
    end

  end
end
