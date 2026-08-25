module Finitio
  module Typescript
    describe "SetType" do

      let(:type) {
        SetType.new(BuiltinType.new(String))
      }

      it 'works as expected' do
        expect(type.to_typescript).to eql('Set<string>')
      end

    end
  end
end
