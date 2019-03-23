require 'spec_helper'
module Finitio
  describe TupleType, "suppremum" do

    subject{
      left.suppremum(right)
    }

    let(:heading){
      Heading.new([Attribute.new(:a, intType),
                   Attribute.new(:b, stringType)])
    }

    let(:left){
      TupleType.new(heading)
    }

    context 'when right is not a tuple type' do
      let(:right){
        stringType
      }

      it 'builds a union type' do
        expect(subject).to be_a(UnionType)
        expect(subject.candidates).to eql([left, right])
      end
    end

    context 'when right is an equal tuple type' do
      let(:h2){
        Heading.new([Attribute.new(:c, intType),
                     Attribute.new(:d, stringType)])
      }
      let(:right) {
        TupleType.new(h2)
      }

      it 'builds a union type' do
        expect(subject).to be_a(UnionType)
        expect(subject.candidates).to eql([left, right])
      end
    end

    context 'when right is a completely different tuple type' do
      let(:right){
        TupleType.new(heading)
      }

      it 'keeps left' do
        expect(subject).to be(left)
      end
    end

    context 'when right is an non-equal tuple type but compatible with TupleType' do
      let(:heading2){
        Heading.new([Attribute.new(:a, nilType),
                     Attribute.new(:b, stringType)])
      }

      let(:right){
        TupleType.new(heading2)
      }

      it 'builds the suppremum as expected' do
        expect(subject).to be_a(TupleType)
        expect(subject.heading[:a].type).to eql(UnionType.new [intType,nilType])
        expect(subject.heading[:b].type).to eql(stringType)
      end
    end

    context 'when right is an non-equal tuple type yielding a MultiTupleType' do
      let(:heading2){
        Heading.new([Attribute.new(:c, nilType),
                     Attribute.new(:b, stringType)])
      }

      let(:right){
        TupleType.new(heading2)
      }

      it 'builds the suppremum as expected' do
        expect(subject).to be_a(MultiTupleType)
        expect(subject.heading[:a].type).to eql(intType)
        expect(subject.heading[:a].required).to eql(false)
        expect(subject.heading[:b].type).to eql(stringType)
        expect(subject.heading[:b].required).to eql(true)
        expect(subject.heading[:c].type).to eql(nilType)
        expect(subject.heading[:c].required).to eql(false)
      end
    end

    context 'when right is an non-equal tuple type yielding a MultiTupleType II' do
      let(:heading2){
        Heading.new([Attribute.new(:a, nilType, false),
                     Attribute.new(:b, stringType)])
      }

      let(:right){
        MultiTupleType.new(heading2)
      }

      it 'builds the suppremum as expected' do
        expect(subject).to be_a(MultiTupleType)
        expect(subject.heading[:a].type).to eql(UnionType.new [intType,nilType])
        expect(subject.heading[:a].required).to eql(false)
        expect(subject.heading[:b].type).to eql(stringType)
      end

      it 'works the other way round too' do
        subject = right.suppremum(left)
        expect(subject).to be_a(MultiTupleType)
        expect(subject.heading[:a].type).to eql(UnionType.new [intType,nilType])
        expect(subject.heading[:a].required).to eql(false)
        expect(subject.heading[:b].type).to eql(stringType)
      end
    end

  end
end
