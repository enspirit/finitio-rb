require 'spec_helper'
module Qrb
  describe AdType, 'dress' do

    let(:type){
      AdType.new(Color, rgb: [intType,   ->(i){ i*2 } ],
                        hex: [floatType, ->(f){ f*3 } ])
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
        ->{
          subject
        }.should raise_error(TypeError, "Invalid value `foo` for Color")
      end
    end

    context 'when the upper raises an error' do
      let(:type){
        AdType.new(Color, rgb: [ intType, ->(t){ raise ArgumentError } ])
      }

      it 'should hide the error' do
        err = type.dress(12) rescue $!
        err.should be_a(TypeError)
        err.message.should eq("Invalid value `12` for Color")
      end
    end

  end
end