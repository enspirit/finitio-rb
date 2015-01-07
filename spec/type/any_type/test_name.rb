require 'spec_helper'
module Finitio
  describe AnyType, "name" do

    subject{ type.name }

    context 'when not provided' do
      let(:type){ AnyType.new }

      it 'uses the default name' do
        expect(subject).to eq("Any")
      end
    end

    context 'when provided' do
      let(:type){ AnyType.new("foo") }

      it 'uses the specified name' do
        expect(subject).to eq("foo")
      end
    end

  end
end
