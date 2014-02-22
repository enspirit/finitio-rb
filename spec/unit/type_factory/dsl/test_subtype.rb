require 'spec_helper'
module Qrb
  describe TypeFactory, "DSL#subtype" do

    let(:factory){ TypeFactory.new }

    let(:constraints){
      { predicate: 1..10 }
    }

    shared_examples_for "The PosInt type" do

      it{ should be_a(SubType) }

      it 'should have the BuiltinType(Integer) super type' do
        subject.super_type.should be_a(BuiltinType)
        subject.super_type.ruby_type.should be(Integer)
      end

      it 'should have the correct constraint' do
        ->{
          subject.from_q(-12)
        }.should raise_error(TypeError)
      end
    end

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

    before do
      subject
    end

    context 'when used with a type' do
      subject{
        supertype = BuiltinType.new(Integer)
        factory.subtype(supertype, constraints)
      }

      it_should_behave_like "The SmallInt structural type"
    end

    context 'when used with a ruby class' do
      subject{
        factory.subtype(Integer, constraints)
      }

      it_should_behave_like "The SmallInt structural type"
    end

    context 'when used with a constraints shorthand' do
      subject{
        factory.subtype(Integer, 1..10)
      }

      it_should_behave_like "The SmallInt structural type"
    end

    context 'when used with a constraint block' do
      subject{
        factory.subtype(Integer){|i| i >=0 }
      }

      it_should_behave_like "The PosInt type"
    end

    context 'when used with a name' do
      subject{
        factory.subtype(Integer, constraints, "SmallInt")
      }

      it_should_behave_like "The SmallInt structural type"

      it 'should have the correct name' do
        subject.name.should eq("SmallInt")
      end
    end

  end
end
