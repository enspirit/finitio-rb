module Finitio
  module JsonSchema
    describe "MultiTupleType" do

      context 'with a true allow extra and some optional attribute' do
        let(:heading){
          Heading.new([
            Attribute.new(:a, anyType),
            Attribute.new(:b, anyType, false),
          ], allow_extra: true)
        }

        let(:multi_tuple_type) {
          MultiTupleType.new(heading)
        }

        it 'works as expected' do
          expect(multi_tuple_type.to_json_schema).to eql({
            type: "object",
            properties: {
              a: {},
              b: {}
            },
            required: [:a],
            additionalProperties: {}
          })
        end
      end

      context 'with a allow extra requiring Strings' do
        let(:heading){
          Heading.new([
          ], allow_extra: BuiltinType.new(String))
        }

        let(:multi_tuple_type) {
          MultiTupleType.new(heading)
        }

        it 'works as expected' do
          expect(multi_tuple_type.to_json_schema).to eql({
            type: "object",
            additionalProperties: { type: "string" }
          })
        end
      end

    end
  end
end
