module Finitio
  module Typescript
    describe "AliasType" do

      let(:alias_type) {
        AliasType.new(anyType, "X")
      }

      it 'works as expected' do
        expect(alias_type.to_typescript).to eql('any')
      end

    end
  end
end
