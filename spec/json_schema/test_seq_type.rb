module Finitio
  module JsonSchema
    describe "SeqType" do

      let(:type) {
        SeqType.new(anyType)
      }

      it 'works as expected' do
        expect(type.to_json_schema).to eql({
          type: "array",
          items: {}
        })
      end

    end
  end
end
