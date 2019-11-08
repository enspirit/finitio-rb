module Finitio
  module JsonSchema
    describe "RelationType" do

      let(:heading){
        Heading.new([Attribute.new(:a, anyType)])
      }

      let(:tuple_type) {
        RelationType.new(heading)
      }

      it 'works as expected' do
        expect(tuple_type.to_json_schema).to eql({
          type: "array",
          items: {
            type: "object",
            properties: {
              a: {}
            },
            required: [:a],
            additionalProperties: false
          },
          uniqueItems: true
        })
      end

    end
  end
end
