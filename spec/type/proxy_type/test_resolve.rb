require 'spec_helper'
module Finitio
  describe ProxyType, "delegation pattern" do

    let(:proxy){ ProxyType.new('Int') }

    subject{ proxy.resolve(system) }

    context 'when type exists' do
      let(:system){ {'Int' => intType} }

      it 'resolves fine' do
        subject
        expect(proxy.target).to eq(intType)
      end
    end

    context 'when type does not exist' do
      let(:system){ {} }

      it 'raises an error' do
        expect{
          subject
        }.to raise_error(Finitio::Error, "No such type `Int`")
      end
    end

  end
end