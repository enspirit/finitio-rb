module Finitio
  module JsonSchema
    describe "UnionType" do

      let(:union_type) {
        UnionType.new([anyType])
      }

      it 'works as expected' do
        expect(union_type.to_json_schema).to eql({
          anyOf: [{}]
        })
      end

    end
  end
end
