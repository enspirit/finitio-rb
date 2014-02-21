require 'spec_helper'
module Qrb
  describe SeqType, 'initialize' do

    subject{
      SeqType.new(intType)
    }

    context 'with valid arguments' do
      it{ should be_a(SeqType) }

      it 'should set the instance variables' do
        subject.elm_type.should eq(intType)
      end
    end

    context 'with invalid arguments' do
      subject{ SeqType.new("foo") }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(ArgumentError, 'Qrb::Type expected, got `foo`')
      end
    end

  end
end
