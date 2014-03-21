require 'spec_helper'
module Finitio
  describe TypeFactory, "Factory#seq" do

    let(:factory){ TypeFactory.new }

    context 'for sequences of scalars' do
      let(:expected){ SeqType.new(intType) }

      context 'when used with [Class]' do
        subject{ factory.type([Integer]) }

        it{ should eq(expected) }
      end

      context 'when used with [Class] and a name' do
        subject{ factory.type([Integer], "MySeq") }

        it{ should eq(expected) }

        it 'should have the correct name' do
          subject.name.should eq("MySeq")
        end
      end
    end

    context 'for pseudo-relations' do
      subject{
        factory.type([{r: Integer}], "MySeq")
      }

      let(:expected){
        factory.seq(factory.tuple(r: Integer))
      }

      it{ should eq(expected) }

      it 'should have the correct name' do
        subject.name.should eq("MySeq")
      end
    end

  end
end
