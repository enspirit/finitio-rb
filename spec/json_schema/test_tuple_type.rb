module Finitio
  module JsonSchema
    describe "TupleType" do

      let(:heading){
        Heading.new([Attribute.new(:a, stringType, true, description: 'Hello')])
      }

      let(:tuple_type) {
        TupleType.new(heading)
      }

      it 'works as expected' do
        expect(tuple_type.to_json_schema).to eql({
          type: "object",
          properties: {
            a: {:type=>"string", :description => 'Hello'}
          },
          required: [:a]
        })
      end

    end
  end
end
