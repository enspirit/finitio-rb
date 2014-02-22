require 'spec_helper'
module Qrb
  describe TypeFactory, "Factory#set" do

    let(:factory){ TypeFactory.new }

    context 'for set of scalars' do
      let(:expected){ SetType.new(intType) }

      context 'when used with {Class}' do
        subject{ factory.type([Integer].to_set) }

        it{ should eq(expected) }
      end

      context 'when used with [Class] and a name' do
        subject{ factory.type([Integer].to_set, "MySet") }

        it{ should eq(expected) }

        it 'should have the correct name' do
          subject.name.should eq("MySet")
        end
      end
    end

    context 'for pseudo-relations' do
      subject{
        factory.type([{r: Integer}].to_set, "MySet")
      }

      let(:expected){
        factory.relation(r: Integer)
      }

      it{ should eq(expected) }

      it 'should have the correct name' do
        subject.name.should eq("MySet")
      end
    end

  end
end
