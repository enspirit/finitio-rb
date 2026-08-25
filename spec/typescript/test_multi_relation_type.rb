module Finitio
  module Typescript
    describe "MultiRelationType" do

      context 'with a true allow extra and some optional attribute' do
        let(:heading){
          Heading.new([
            Attribute.new(:a, anyType),
            Attribute.new(:b, anyType, false),
          ], allow_extra: true)
        }

        let(:multi_relation_type) {
          MultiRelationType.new(heading)
        }

        it 'works as expected' do
          expect(multi_relation_type.to_typescript).to eql("Set<{ a: any, b?: any } & { [key: string]: any }>")
        end
      end

      context 'with a allow extra requiring Strings' do
        let(:heading){
          Heading.new([
          ], allow_extra: BuiltinType.new(String))
        }

        let(:multi_relation_type) {
          MultiRelationType.new(heading)
        }

        it 'works as expected' do
          expect(multi_relation_type.to_typescript).to eql("Set<{ [key: string]: string }>")
        end
      end

    end
  end
end
