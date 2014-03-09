require 'spec_helper'
module Qrb
  describe AdType, 'initialize' do

    subject{
      AdType.new(Color, rgb: [intType,   Color.method(:rgb), Qrb::IDENTITY ],
                        hex: [floatType, Color.method(:hex), Qrb::IDENTITY ])
    }

    context 'with valid arguments' do
      it{ should be_a(AdType) }

      it 'should set the instance variables' do
        subject.ruby_type.should be(Color)
        subject.contracts.should be_a(Hash)
      end
    end

    context 'with invalid arguments (I)' do
      subject{ AdType.new("foo", {}) }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(ArgumentError, 'Module expected, got `foo`')
      end
    end

    context 'with invalid arguments (II)' do
      subject{ AdType.new(Object, "bar") }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(ArgumentError, 'Hash expected, got `bar`')
      end
    end

  end
end
