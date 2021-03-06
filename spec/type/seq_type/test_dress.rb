require 'spec_helper'
module Finitio
  describe SeqType, 'dress' do

    let(:type){ SeqType.new(byte) }

    subject{ type.dress(arg) }

    context 'with an empty array' do
      let(:arg){ [] }

      it{ should eq([]) }
    end

    context 'with a valid array' do
      let(:arg){ [12, 16] }

      it{ should eq([12, 16]) }
    end

    context 'with not a enumerable' do
      let(:arg){ "foo" }

      it 'should raise an error' do
        expect{
          subject
        }.to raise_error("Invalid [Byte] `foo`")
      end
    end

    context 'with an array with non bytes' do
      let(:arg){ [2, 4, -12] }

      subject{
        type.dress(arg) rescue $!
      }

      it 'should raise an error' do
        expect(subject).to be_a(TypeError)
        expect(subject.message).to eq("Invalid Byte `-12`")
      end

      it 'should have correct location' do
        expect(subject.location).to eq("2")
      end
    end

  end
end
