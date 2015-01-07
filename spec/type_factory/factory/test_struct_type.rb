require 'spec_helper'
module Finitio
  describe TypeFactory, "Factory#struct" do

    let(:factory){ TypeFactory.new }

    context 'when used with [Integer, Float]' do
      subject{ factory.type([Integer, Float]) }

      it{ should be_a(StructType) }

      it 'should have the expected components' do
        expect(subject.component_types).to eq([intType, floatType])
      end
    end

  end
end
