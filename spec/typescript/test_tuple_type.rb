module Finitio
  module Typescript
    describe "TupleType" do

      let(:heading){
        Heading.new([Attribute.new(:a, anyType)])
      }

      let(:tuple_type) {
        TupleType.new(heading)
      }

      it 'works as expected' do
        expect(tuple_type.to_typescript).to eql("{ a: any }")
      end
    end
  end
end
