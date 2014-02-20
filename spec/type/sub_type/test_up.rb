require 'spec_helper'
module Qrb
  describe SubType, "up" do

    let(:type){ SubType.new("byte", intType, default: ->(i){ i>0 }, small: ->(i){ i<255 }) }

    subject{ type.up(arg) }

    context 'with an valid Integer' do
      let(:arg){ 12 }

      it{ should be(arg) }
    end

    context 'with a Float' do
      let(:arg){ 12.0 }

      it 'should raise an Error' do
        ->{
          subject
        }.should raise_error(UpError, "Invalid value `12.0` for byte")
      end

      it "should have the proper cause from super type's up" do
        begin
          subject
          raise
        rescue UpError => ex
          ex.cause.should be_a(UpError)
          ex.cause.message.should eq("Invalid value `12.0` for intType")
        end
      end
    end

    context 'with a negative integer' do
      let(:arg){ -12 }

      it 'should raise an Error' do
        ->{
          subject
        }.should raise_error(UpError, "Invalid value `-12` for byte")
      end
    end

    context 'with a non small integer' do
      let(:arg){ 1000 }

      it 'should raise an Error' do
        ->{
          subject
        }.should raise_error(UpError, "Invalid value `1000` for byte (not small)")
      end
    end

  end
end
