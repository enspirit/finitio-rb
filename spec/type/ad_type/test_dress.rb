require 'spec_helper'
module Finitio
  describe AdType, 'dress' do

    let(:rgb){
      Contract.new(intType, ->(i){ i*2 }, Finitio::IDENTITY, :rgb)
    }

    let(:hex){
      Contract.new(floatType, ->(f){ f*3 }, Finitio::IDENTITY, :hex)
    }

    let(:type){
      AdType.new(Color, [rgb, hex])
    }

    subject{
      type.dress(arg)
    }

    context 'with a color' do
      let(:arg){ Color.new(12, 13, 15) }

      it{ should be(arg) }
    end

    context 'with an integer' do
      let(:arg){ 12 }

      it{ should eq(24) }
    end

    context 'with a float' do
      let(:arg){ 12.0 }

      it{ should eq(36.0) }
    end

    context 'with an unrecognized' do
      let(:arg){ "foo" }

      it 'should raise an error' do
        expect{
          subject
        }.to raise_error(TypeError, "Invalid value `foo` for Color")
      end
    end

    context 'when the upper raises an error' do
      let(:rgb){
        Contract.new(intType, ->(t){ raise ArgumentError }, Finitio::IDENTITY, :rgb)
      }
      let(:type){
        AdType.new(Color, [ rgb ])
      }

      it 'should hide the error' do
        err = type.dress(12) rescue $!
        expect(err).to be_a(TypeError)
        expect(err.message).to eq("Invalid value `12` for Color")
      end
    end

  end
end