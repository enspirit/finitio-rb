require 'spec_helper'
module Qrb
  describe RealmBuilder, "Factory#set" do

    let(:builder){ RealmBuilder.new }

    context 'for set of scalars' do
      let(:expected){ SetType.new(intType) }

      context 'when used with {Class}' do
        subject{ builder.type([Integer].to_set) }

        it{ should eq(expected) }
      end

      context 'when used with [Class] and a name' do
        subject{ builder.type([Integer].to_set, "MySet") }

        it{ should eq(expected) }

        it 'should have the correct name' do
          subject.name.should eq("MySet")
        end
      end
    end

    context 'for pseudo-relations' do
      subject{
        builder.type([{r: Integer}].to_set, "MySet")
      }

      let(:expected){
        builder.relation(r: Integer)
      }

      it{ should eq(expected) }

      it 'should have the correct name' do
        subject.name.should eq("MySet")
      end
    end

  end
end
