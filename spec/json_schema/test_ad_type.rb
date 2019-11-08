module Finitio
  module JsonSchema
    describe "AdType" do

      let(:type) {
        type = AdType.new(Color, [rgb_contract, hex_contract])
      }

      it 'works as expected' do
        expect(type.to_json_schema).to eql({
          anyOf: [
            { type: "integer" },
            { type: "string" }
          ]
        })
      end

    end
  end
end
