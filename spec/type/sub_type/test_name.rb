require 'spec_helper'
module Finitio
  describe SubType, "name" do

    subject{ type.name }

    context 'when provided' do
      let(:type){ SubType.new(intType, [positive], "Foo") }

      it 'uses the specified one' do
        expect(subject).to eq("Foo")
      end
    end

    context 'when not provided' do
      let(:type){ SubType.new(intType, [positive]) }

      it 'uses the first constraint name' do
        expect(subject).to eq("Positive")
      end
    end

  end
end
