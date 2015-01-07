require 'spec_helper'
module Finitio
  describe TypeFactory, "DSL#seq" do

    let(:factory){ TypeFactory.new }

    shared_examples_for "The Seq[Int] type" do

      it{ should be_a(SeqType) }

      it 'should have the correct element type' do
        expect(subject.elm_type).to eq(intType)
      end
    end

    before do
      subject
    end

    context 'when used with a ruby class' do
      subject{
        factory.seq(Integer)
      }

      it_should_behave_like "The Seq[Int] type"

      it 'should have the correct name' do
        expect(subject.name).to eq("[Integer]")
      end
    end

    context 'when used with a type' do
      subject{
        factory.seq(intType)
      }

      it_should_behave_like "The Seq[Int] type"

      it 'should have the correct name' do
        expect(subject.name).to eq("[intType]")
      end
    end

    context 'when used with an explicit name' do
      subject{
        factory.seq(intType, "MySeq")
      }

      it_should_behave_like "The Seq[Int] type"

      it 'should have the correct name' do
        expect(subject.name).to eq("MySeq")
      end
    end

  end
end
