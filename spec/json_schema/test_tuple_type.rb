module Finitio
  module JsonSchema
    describe "TupleType" do

      let(:heading){
        Heading.new([Attribute.new(:a, anyType)])
      }

      let(:tuple_type) {
        TupleType.new(heading)
      }

      it 'works as expected' do
        expect(tuple_type.to_json_schema).to eql({
          type: "object",
          properties: {
            a: {}
          },
          required: [:a],
          additionalProperties: false
        })
      end

    end
  end
end
