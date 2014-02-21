require 'spec_helper'
module Qrb
  describe RealmBuilder, "DSL#subtype" do

    let(:builder){ RealmBuilder.new }

    let(:constraints){
      { predicate: 1..10 }
    }

    shared_examples_for "The SmallInt structural type" do

      it{ should be_a(SubType) }

      it 'should have the BuiltinType(Integer) super type' do
        subject.super_type.should be_a(BuiltinType)
        subject.super_type.ruby_type.should be(Integer)
      end

      it 'should have the correct constraints' do
        subject.constraints.should eq(constraints)
      end
    end

    describe "The normal version" do

      before do
        subject
        # it should not be saved
        builder.realm[subject.name].should be_nil
      end

      context 'when used with a type' do
        subject{
          supertype = BuiltinType.new(Integer)
          builder.subtype(supertype, constraints)
        }

        it_should_behave_like "The SmallInt structural type"
      end

      context 'when used with a ruby class' do
        subject{
          builder.subtype(Integer, constraints)
        }

        it_should_behave_like "The SmallInt structural type"
      end

      context 'when used with a constraints shorthand' do
        subject{
          builder.subtype(Integer, 1..10)
        }

        it_should_behave_like "The SmallInt structural type"
      end

      context 'when used with a name' do
        subject{
          builder.subtype(Integer, constraints, "SmallInt")
        }

        it_should_behave_like "The SmallInt structural type"

        it 'should have the correct name' do
          subject.name.should eq("SmallInt")
        end
      end

      context 'when used with a ruby class and the builtin already exists' do
        subject{
          @supertype = builder.builtin!(Integer)
          builder.subtype(Integer, constraints)
        }

        it_should_behave_like "The SmallInt structural type"

        it 'should reuse the builtin type' do
          subject.super_type.should be(@supertype)
        end
      end

    end

    describe "The ! version" do
      subject{
        builder.subtype!(Integer, constraints)
      }

      it_should_behave_like "The SmallInt structural type"

      it 'should be saved' do
        builder.realm[subject.name].should be(subject)
      end
    end

  end
end
