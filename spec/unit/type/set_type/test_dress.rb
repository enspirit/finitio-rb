require 'spec_helper'
module Qrb
  describe SetType, 'dress' do

    let(:type){ SetType.new(byte) }

    subject{ type.dress(arg) }

    context 'with an empty array' do
      let(:arg){ [] }

      it{ should eq([].to_set) }
    end

    context 'with a valid array' do
      let(:arg){ [12, 16] }

      it{ should eq([12, 16].to_set) }
    end

    context 'with not a enumerable' do
      let(:arg){ "foo" }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error("Invalid value `foo` for {Byte}")
      end
    end

    context 'with an array with non bytes' do
      let(:arg){ [2, 4, -12] }

      subject{
        type.dress(arg) rescue $!
      }

      it 'should raise an error' do
        subject.should be_a(TypeError)
        subject.message.should eq("Invalid value `-12` for Byte")
      end

      it 'should have correct location' do
        subject.location.should eq("2")
      end
    end

    context 'with an array with duplicates' do
      let(:arg){ [2, 4, 2] }

      subject{
        type.dress(arg) rescue $!
      }

      it 'should raise an error' do
        subject.should be_a(TypeError)
        subject.message.should eq("Duplicate value `2`")
      end

      it 'should have correct location' do
        subject.location.should eq("2")
      end
    end

  end
end
