module Finitio
  module JsonSchema
    describe "AliasType" do

      let(:alias_type) {
        AliasType.new(anyType, "X")
      }

      it 'works as expected' do
        expect(alias_type.to_json_schema).to eql({})
      end

    end
  end
end
