require 'spec_helper'
module Finitio
  describe Attribute, "initialize" do

    context 'when implicitely required' do
      subject{ Attribute.new(:red, intType) }

      it 'should correctly set the instance variables' do
        expect(subject.name).to eq(:red)
        expect(subject.type).to eq(intType)
        expect(subject).to be_required
      end
    end

    context 'when not required' do
      subject{ Attribute.new(:red, intType, false) }

      it 'should correctly set the instance variables' do
        expect(subject.name).to eq(:red)
        expect(subject.type).to eq(intType)
        expect(subject).not_to be_required
      end
    end

  end
end
