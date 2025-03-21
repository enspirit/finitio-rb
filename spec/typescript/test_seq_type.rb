module Finitio
  module Typescript
    describe "SeqType" do

      let(:type) {
        SeqType.new(BuiltinType.new(String))
      }

      it 'works as expected' do
        expect(type.to_typescript).to eql('Array<string>')
      end

    end
  end
end
