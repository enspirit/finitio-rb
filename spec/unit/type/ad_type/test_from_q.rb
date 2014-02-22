require 'spec_helper'
module Qrb
  describe AdType, 'from_q' do

    let(:type){
      AdType.new(Color, rgb: [intType, RgbContract], hex: [floatType, HexContract])
    }

    subject{
      type.from_q(arg)
    }

    context 'with a color' do
      let(:arg){ Color.new(:rgb, 12) }

      it{ should be(arg) }
    end

    context 'with an integer' do
      let(:arg){ 12 }

      it{ should be_a(Color) }

      it 'should have used the RGB contract' do
        subject.contract.should eq(:rgb)
        subject.rep.should eq(12)
      end
    end

    context 'with a float' do
      let(:arg){ 12.0 }

      it{ should be_a(Color) }

      it 'should have used the HEX contract' do
        subject.contract.should eq(:hex)
        subject.rep.should eq(12.0)
      end
    end

    context 'with an unrecognized' do
      let(:arg){ "foo" }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(UpError, "Invalid value `foo` for Color")
      end
    end

  end
end