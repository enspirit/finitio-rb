require 'spec_helper'
module Finitio
  describe UnionType, "initialize" do

    context 'with valid candidates' do
      let(:union){ UnionType.new([intType, floatType]) }

      it 'sets the variable instances' do
        expect(union.candidates).to eq([intType, floatType])
      end
    end

    context 'with invalid candidates' do
      let(:union){ UnionType.new(["bar"]) }

      it 'should raise an error' do
        expect{
          union
        }.to raise_error(ArgumentError, %Q{[Finitio::Type] expected, got ["bar"]})
      end
    end

  end
end
