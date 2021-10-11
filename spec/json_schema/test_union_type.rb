module Finitio
  module JsonSchema
    describe "UnionType" do

      let(:string_type) {
        BuiltinType.new(String)
      }

      let(:int_type) {
        BuiltinType.new(Integer)
      }

      let(:true_type) {
        BuiltinType.new(TrueClass)
      }

      let(:false_type) {
        BuiltinType.new(FalseClass)
      }

      let(:nil_type) {
        BuiltinType.new(NilClass)
      }

      context 'when used with a single type' do
        let(:union_type) {
          UnionType.new([string_type])
        }

        it 'works as expected' do
          expect(union_type.to_json_schema).to eql({
            :type => "string"
          })
        end
      end

      context 'when used with two types' do
        let(:union_type) {
          UnionType.new([string_type, int_type])
        }

        it 'works as expected' do
          expect(union_type.to_json_schema).to eql({
            anyOf: [{:type => "string"}, {:type => "integer"}]
          })
        end
      end

      context 'when used with a |Nil' do
        let(:union_type) {
          UnionType.new([string_type, int_type, nil_type])
        }

        it 'works as expected' do
          expect(union_type.to_json_schema).to eql({
            anyOf: [{:type => "string"}, {:type => "integer"}]
          })
        end
      end

      context 'when used with a TrueClass|FalseClass' do
        let(:union_type) {
          UnionType.new([true_type, false_type])
        }

        it 'works as expected' do
          expect(union_type.to_json_schema).to eql({
            :type => "boolean"
          })
        end
      end

    end
  end
end
