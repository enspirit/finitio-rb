require 'spec_helper'
module Qrb
  describe RealmBuilder, "Factory#seq" do

    let(:builder){ RealmBuilder.new }

    context 'for sequences of scalars' do
      let(:expected){ SeqType.new(intType) }

      context 'when used with [Class]' do
        subject{ builder.type([Integer]) }

        it{ should eq(expected) }
      end

      context 'when used with [Class] and a name' do
        subject{ builder.type([Integer], "MySeq") }

        it{ should eq(expected) }

        it 'should have the correct name' do
          subject.name.should eq("MySeq")
        end
      end
    end

    context 'for pseudo-relations' do
      subject{
        builder.type([{r: Integer}], "MySeq")
      }

      let(:expected){
        builder.seq(builder.tuple(r: Integer))
      }

      it{ should eq(expected) }

      it 'should have the correct name' do
        subject.name.should eq("MySeq")
      end
    end

  end
end
