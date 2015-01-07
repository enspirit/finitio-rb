require 'spec_helper'
module Finitio
  describe BuiltinType, "name" do

    subject{ type.name }

    context 'when not provided' do
      let(:type){ BuiltinType.new(Integer) }

      it 'uses the default name' do
        expect(subject).to eq("Integer")
      end
    end

    context 'when provided' do
      let(:type){ BuiltinType.new(Integer, "int") }

      it 'uses the specified name' do
        expect(subject).to eq("int")
      end
    end

  end
end
