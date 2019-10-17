require 'spec_helper'
module Finitio
  describe AdType, 'initialize' do


    subject{
      AdType.new(Color, [rgb_contract, hex_contract])
    }

    context 'with valid arguments' do
      it{ should be_a(AdType) }

      it 'should set the instance variables' do
        expect(subject.ruby_type).to be(Color)
        expect(subject.contracts).to be_a(Array)
      end
    end

    context 'with invalid arguments (I)' do
      subject{ AdType.new("foo", {}) }

      it 'should raise an error' do
        expect{
          subject
        }.to raise_error(ArgumentError, 'Module expected, got `foo`')
      end
    end

    context 'with invalid arguments (II)' do
      subject{ AdType.new(Object, "bar") }

      it 'should raise an error' do
        expect{
          subject
        }.to raise_error(ArgumentError, '[Contract] expected, got `bar`')
      end
    end

  end
end
