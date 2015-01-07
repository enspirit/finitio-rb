require 'spec_helper'
module Finitio
  describe BuiltinType, "dress" do

    let(:type){ BuiltinType.new(Integer, 'int') }

    subject{ type.dress(arg) }

    context 'with an Integer' do
      let(:arg){ 12 }

      it{ should be(arg) }
    end

    context 'with a Float' do
      let(:arg){ 12.0 }

      subject{
        type.dress(arg) rescue $!
      }

      it 'should raise an Error' do
        expect(subject).to be_a(TypeError)
        expect(subject.message).to eq("Invalid value `12.0` for int")
      end

      it 'should have no location' do
        expect(subject.location).to eq('')
      end
    end

  end
end
