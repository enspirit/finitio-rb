require 'spec_helper'
module Qrb
  describe BuiltinType, "up" do

    let(:type){ BuiltinType.new("int", Integer) }

    subject{ type.up(arg) }

    context 'with an Integer' do
      let(:arg){ 12 }

      it{ should be(arg) }
    end

    context 'with a Float' do
      let(:arg){ 12.0 }

      it 'should raise an Error' do
        ->{
          subject
        }.should raise_error(UpError, "Invalid value `12.0` for int")
      end
    end

  end
end
