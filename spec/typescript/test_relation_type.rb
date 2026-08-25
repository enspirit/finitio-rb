module Finitio
  module Typescript
    describe "RelationType" do

      let(:heading){
        Heading.new([Attribute.new(:a, anyType)])
      }

      let(:tuple_type) {
        RelationType.new(heading)
      }

      it 'works as expected' do
        expect(tuple_type.to_typescript).to eql("Set<{ a: any }>")
      end

    end
  end
end
