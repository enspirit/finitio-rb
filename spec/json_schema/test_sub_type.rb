module Finitio
  module JsonSchema
    describe "SubType" do

      let(:type) {
        byte
      }

      it 'skips constraints (for now)' do
        expect(byte.to_json_schema).to eql({
          type: "integer"
        })
      end

    end
  end
end
