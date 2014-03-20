require 'spec_helper'
module Finitio
  describe SetType, 'initialize' do

    subject{
      SetType.new(intType)
    }

    context 'with valid arguments' do
      it{ should be_a(SetType) }

      it 'should set the instance variables' do
        subject.elm_type.should eq(intType)
      end
    end

    context 'with invalid arguments' do
      subject{ SetType.new("foo") }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(ArgumentError, 'Finitio::Type expected, got `foo`')
      end
    end

  end
end
