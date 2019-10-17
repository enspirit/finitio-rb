require 'spec_helper'
module Finitio
  describe Generation do

    subject {
      Generation.new({
        :heuristic  => Generation::Heuristic::Constant.new,
        :generators => generators
      })
    }

    let(:generators) {
      {}
    }

    class SubString < String
    end

    describe 'when called on scalar types' do

      it 'works for nil' do
        expect(subject.call(nilType)).to eql(nil)
      end

      it 'works for ints' do
        expect(subject.call(intType)).to eql(99)
      end

      it 'works for floats' do
        expect(subject.call(floatType)).to eql(99.99)
      end

      it 'works for strings' do
        expect(subject.call(stringType)).to eql("Hello world")
      end

      it 'works for true' do
        expect(subject.call(trueType)).to be(true)
      end

      it 'works for false' do
        expect(subject.call(falseType)).to be(false)
      end

      it 'works on ruby sub types' do
        expect(subject.call(BuiltinType.new(SubString))).to eql("Hello world")
      end

    end

    describe 'when called on Any type' do

      it 'works' do
        expect {
          subject.call(anyType)
        }.not_to raise_error
      end

    end

    describe 'when called on an alias type' do

      it 'works' do
        expect(subject.call(AliasType.new(intType, "x"))).to eql(99)
      end

    end

    describe 'when called on an sub type' do

      it 'works' do
        expect(subject.call(byte)).to eql(99)
      end

    end

    describe 'when called on a collection type' do

      it 'works on a SeqType' do
        got = subject.call(SeqType.new(intType))
        expect(got).to be_a(Array)
        expect(got.all?{|x| x==99 }).to be_truthy
      end

      it 'works on a SetType' do
        got = subject.call(SetType.new(intType))
        expect(got).to be_a(Array)
        expect(got.all?{|x| x==99 }).to be_truthy
      end

    end

    describe 'when called on tuple types' do

      it 'works as expected' do
        type = TupleType.new(Heading.new [Attribute.new(:i, intType)])
        expect(subject.call(type)).to eql({i: 99})
      end

      it 'works as expected' do
        type = MultiTupleType.new(Heading.new [Attribute.new(:i, intType)])
        expect(subject.call(type)).to eql({i: 99})
      end

    end

    describe 'when called on relation types' do

      it 'works as expected' do
        type = RelationType.new(Heading.new [Attribute.new(:i, intType)])
        expect(subject.call(type)).to eql([{i: 99}])
      end

      it 'works as expected' do
        type = MultiRelationType.new(Heading.new [Attribute.new(:i, intType)])
        expect(subject.call(type)).to eql([{i: 99}])
      end
    end

    describe 'when called on a union type' do

      it 'works as expected' do
        type = UnionType.new([trueType, falseType])
        expect([true, false].include? subject.call(type)).to be_truthy
      end

    end

    describe 'when called on an AD type' do

      it 'works' do
        type = AdType.new(Color, [rgb_contract])
        expect(subject.call(byte)).to eql(99)
      end

    end

    describe 'when examples are provided in metadata' do

      it 'takes the priority' do
        type = AliasType.new(intType, "X", { examples: [97] })
        expect(subject.call(type)).to eql(97)
      end

    end

    describe 'when a generator exists' do

      let(:generators) {
        {
          "X" => ->(type, gen, _) { 96 },
          "Y" => ->(type, gen, world) { world }
        }
      }

      it 'takes the priority even over examples' do
        type = AliasType.new(intType, "X", { examples: [97] })
        expect(subject.call(type)).to eql(96)
      end

      it 'lets pass a world' do
        type = AliasType.new(intType, "Y", { examples: [97] })
        expect(subject.call(type, 17)).to eql(17)
      end

    end

  end
end