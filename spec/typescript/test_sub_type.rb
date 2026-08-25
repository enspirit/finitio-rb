module Finitio
  module Typescript
    describe "SubType" do

      let(:type) {
        byte
      }

      it 'skips constraints (for now)' do
        expect(byte.to_typescript).to eql("intType")
      end

    end
  end
end
