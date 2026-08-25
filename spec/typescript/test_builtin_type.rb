module Finitio
  module Typescript
    describe 'BuiltinType' do

      let(:builtin_type) {
        BuiltinType.new(ruby_type)
      }

      subject {
        builtin_type.to_typescript
      }

      context 'with NilClass' do
        let(:ruby_type){ NilClass }

        it 'works' do
          expect(subject).to eql('null')
        end
      end

      context 'with String' do
        let(:ruby_type){ String }

        it 'works' do
          expect(subject).to eql('string')
        end
      end

      [Fixnum, Bignum, Integer].each do |rt|
        context 'with #{rt}' do
          let(:ruby_type){ rt }

          it 'works' do
            expect(subject).to eql('number')
          end
        end
      end

      [Float, Numeric].each do |rt|
        context 'with #{rt}' do
          let(:ruby_type){ rt }

          it 'works' do
            expect(subject).to eql('number')
          end
        end
      end

    end
  end
end
