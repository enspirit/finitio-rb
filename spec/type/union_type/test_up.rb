require 'spec_helper'
module Qrb
  describe UnionType, "up" do

    let(:int_type)  { BuiltinType.new("int", Integer)  }
    let(:float_type){ BuiltinType.new("float", Float)  }
    let(:type)      { UnionType.new("union", [int_type, float_type]) }

    subject{ type.up(arg) }

    context 'with an Integer' do
      let(:arg){ 12 }

      it{ should be(arg) }
    end

    context 'with a Float' do
      let(:arg){ 12.0 }

      it{ should be(arg) }
    end

    context 'with a String' do
      let(:arg){ "foo" }

      it 'should raise an Error' do
        ->{
          subject
        }.should raise_error(UpError, "Invalid value `foo` for union")
      end
    end

  end
end
