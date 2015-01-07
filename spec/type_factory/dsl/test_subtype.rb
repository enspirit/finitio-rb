require 'spec_helper'
module Finitio
  describe TypeFactory, "DSL#subtype" do

    let(:factory){ TypeFactory.new }

    let(:constraints){
      { predicate: 1..10 }
    }

    shared_examples_for "The PosInt type" do

      it{ should be_a(SubType) }

      it 'should have the BuiltinType(Integer) super type' do
        expect(subject.super_type).to be_a(BuiltinType)
        expect(subject.super_type.ruby_type).to be(Integer)
      end

      it 'should have the correct constraint' do
        expect{
          subject.dress(-12)
        }.to raise_error(TypeError)
      end
    end

    shared_examples_for "The SmallInt structural type" do

      it{ should be_a(SubType) }

      it 'should have the BuiltinType(Integer) super type' do
        expect(subject.super_type).to be_a(BuiltinType)
        expect(subject.super_type.ruby_type).to be(Integer)
      end

      it 'should have the correct constraints' do
        subject.constraints.each do |c|
          expect(c).to be_a(Constraint)
        end
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
        expect(subject.name).to eq("SmallInt")
      end
    end

  end
end
