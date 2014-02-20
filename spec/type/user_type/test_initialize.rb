require 'spec_helper'
module Qrb
  describe UserType, 'initialize' do

    subject{
      UserType.new(intType   => ->(t){ Foo.new },
                   floatType => ->(t){ Bar.new })
    }

    context 'with valid arguments' do
      it{ should be_a(UserType) }

      it 'should set the instance variables' do
        subject.contracts.should be_a(Hash)
      end
    end

    context 'with invalid arguments' do
      subject{ UserType.new("foo") }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(ArgumentError, 'Hash expected, got `foo`')
      end
    end

  end
end
