module Finitio
  module JsonSchema
    describe "StructType" do

      let(:type) {
        StructType.new([anyType,anyType])
      }

      it 'works as expected' do
        expect(type.to_json_schema).to eql({
          type: "array",
          items: [{},{}]
        })
      end

    end
  end
end
