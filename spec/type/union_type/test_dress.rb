require 'spec_helper'
module Finitio
  describe UnionType, "dress" do

    let(:type){ UnionType.new([intType, floatType], "union") }

    subject{ type.dress(arg) }

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
        type.dress(arg) rescue $!
      }

      it 'should raise an Error' do
        expect(subject).to be_a(TypeError)
        expect(subject.message).to eq("Invalid union `foo`")
      end

      it 'should have no cause' do
        expect(subject.cause).to be_nil
      end

      it 'should have an empty location' do
        expect(subject.location).to eq('')
      end
    end

  end
end
