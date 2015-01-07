require 'spec_helper'
module Finitio
  describe AdType, 'initialize' do

    let(:rgb){
      Contract.new(intType, Color.method(:rgb), Finitio::IDENTITY, :rgb)
    }

    let(:hex){
      Contract.new(floatType, Color.method(:hex), Finitio::IDENTITY, :hex)
    }

    subject{
      AdType.new(Color, [rgb, hex])
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
