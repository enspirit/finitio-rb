require 'spec_helper'
module Finitio
  describe SetType, 'initialize' do

    subject{
      SetType.new(intType)
    }

    context 'with valid arguments' do
      it{ should be_a(SetType) }

      it 'should set the instance variables' do
        expect(subject.elm_type).to eq(intType)
      end
    end

    context 'with invalid arguments' do
      subject{ SetType.new("foo") }

      it 'should raise an error' do
        expect{
          subject
        }.to raise_error(ArgumentError, 'Finitio::Type expected, got `foo`')
      end
    end

  end
end
