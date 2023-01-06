module Finitio
  module Typescript
    describe "StructType" do

      let(:type) {
        StructType.new([anyType, BuiltinType.new(String)])
      }

      it 'works as expected' do
        expect(type.to_typescript).to eql('[any, string]')
      end

    end
  end
end
