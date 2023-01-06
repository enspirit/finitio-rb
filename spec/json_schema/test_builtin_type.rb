module Finitio
  module JsonSchema
    describe "BuiltinType" do

      let(:builtin_type) {
        BuiltinType.new(ruby_type)
      }

      subject {
        builtin_type.to_json_schema
      }

      context 'with NilClass' do
        let(:ruby_type){ NilClass }

        it 'works' do
          expect(subject).to eql({ type: "string" })
        end
      end

      context 'with String' do
        let(:ruby_type){ String }

        it 'works' do
          expect(subject).to eql({ type: "string" })
        end
      end

      [Fixnum, Bignum, Integer].each do |rt|
        context "with #{rt}" do
          let(:ruby_type){ rt }

          it 'works' do
            expect(subject).to eql({ type: "integer" })
          end
        end
      end

      [Float, Numeric].each do |rt|
        context "with #{rt}" do
          let(:ruby_type){ rt }

          it 'works' do
            expect(subject).to eql({ type: "number" })
          end
        end
      end

    end
  end
end
