require 'spec_helper'
module Finitio
  describe Type, "unconstrained" do

    subject{
      type.unconstrained
    }

    context "on Any" do
      let(:type){
        ANY_TYPE
      }

      it 'returns the type itself by default' do
        expect(subject).to be(type)
      end
    end

    context "on a Builtin" do
      let(:type){
        intType
      }

      it 'returns the type itself by default' do
        expect(subject).to be(type)
      end
    end

    context 'on a sub type' do
      let(:type){
        pos_byte
      }

      it 'returns the most unconstrained super type' do
        expect(subject).to be(intType)
      end
    end

    context 'on an alias type' do
      let(:type){
        AliasType.new(pos_byte, "alias")
      }

      it 'returns an alias on the most unconstrained super type' do
        expect(subject).to be_a(AliasType)
        expect(subject.target).to be(intType)
        expect(subject.name).to eql("alias")
      end
    end

    context 'on an proxy type' do
      let(:type){
        ProxyType.new("pos_byte", pos_byte)
      }

      it 'returns the most unconstrained super type' do
        expect(subject).to be(intType)
      end
    end

    context 'on an seq type' do
      let(:type){
        SeqType.new(pos_byte)
      }

      it 'returns the most unconstrained super type' do
        expect(subject).to be_a(SeqType)
        expect(subject.elm_type).to be(intType)
      end
    end

    context 'on an set type' do
      let(:type){
        SetType.new(pos_byte)
      }

      it 'returns the most unconstrained super type' do
        expect(subject).to be_a(SetType)
        expect(subject.elm_type).to be(intType)
      end
    end

    context 'on an tuple type' do
      let(:type){
        TupleType.new(Heading.new [Attribute.new(:i, pos_byte)])
      }

      it 'returns the most unconstrained super type' do
        expect(subject).to be_a(TupleType)
        expect(subject.heading[:i].type).to be(intType)
      end
    end

    context 'on an relation type' do
      let(:type){
        RelationType.new(Heading.new [Attribute.new(:i, pos_byte)])
      }

      it 'returns the most unconstrained super type' do
        expect(subject).to be_a(RelationType)
        expect(subject.heading[:i].type).to be(intType)
      end
    end

    context 'on an union type' do
      let(:type){
        UnionType.new([pos_byte])
      }

      it 'returns the most unconstrained super type' do
        expect(subject).to be_a(UnionType)
        expect(subject.candidates).to eql([intType])
      end
    end

    context 'on an struct type' do
      let(:type){
        StructType.new([pos_byte])
      }

      it 'returns the most unconstrained super type' do
        expect(subject).to be_a(StructType)
        expect(subject.component_types).to eql([intType])
      end
    end

    context 'on a high-order type' do
      let(:type){
        HighOrderType.new(["V"], pos_byte)
      }

      it 'returns the most unconstrained super type' do
        expect(subject).to be_a(HighOrderType)
        expect(subject.defn).to be(intType)
      end
    end

    context 'on an AD type' do
      let(:type){
        AdType.new(Color, [rgb_contract])
      }

      it 'returns the most unconstrained super type' do
        expect(subject).to be_a(AdType)
        expect(subject.contracts).to eql([rgb_contract.unconstrained])
      end
    end

  end
end
