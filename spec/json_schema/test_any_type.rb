module Finitio
  module JsonSchema
    describe "AnyType" do

      it 'works as expected' do
        expect(anyType.to_json_schema).to eql({})
      end

    end
  end
end
