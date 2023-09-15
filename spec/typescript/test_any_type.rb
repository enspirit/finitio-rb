module Finitio
  module Typescript
    describe "AnyType" do

      it 'works as expected' do
        expect(anyType.to_typescript).to eql('any')
      end

    end
  end
end
