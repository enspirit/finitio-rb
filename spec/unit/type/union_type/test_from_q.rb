require 'spec_helper'
module Qrb
  describe UnionType, "from_q" do

    let(:type)      { UnionType.new([intType, floatType], "union") }

    subject{ type.from_q(arg) }

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

      subject{
        type.from_q(arg) rescue $!
      }

      it 'should raise an Error' do
        subject.should be_a(UpError)
        subject.message.should eq("Invalid value `foo` for union")
      end

      it 'should have no cause' do
        subject.cause.should be_nil
      end

      it 'should have an empty location' do
        subject.location.should eq('')
      end
    end

  end
end
