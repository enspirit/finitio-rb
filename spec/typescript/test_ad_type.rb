module Finitio
  module Typescript
    describe "AdType" do

      let(:type) {
        type = AdType.new(Color, [rgb_contract, hex_contract])
      }

      it 'works as expected' do
        expect(type.to_typescript).to eql("intType|stringType")
      end

    end
  end
end
