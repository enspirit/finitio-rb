module Finitio
  module JsonSchema
    describe "SetType" do

      let(:type) {
        SetType.new(anyType)
      }

      it 'works as expected' do
        expect(type.to_json_schema).to eql({
          type: "array",
          items: {},
          uniqueItems: true
        })
      end

    end
  end
end
