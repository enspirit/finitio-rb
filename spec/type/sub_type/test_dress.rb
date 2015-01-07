require 'spec_helper'
module Finitio
  describe SubType, "dress" do

    let(:type){ SubType.new(intType, [byte_full], "byte") }

    subject{ type.dress(arg) }

    context 'with an valid Integer' do
      let(:arg){ 12 }

      it{ should be(arg) }
    end

    context 'when raising an Error' do

      subject do
        type.dress(arg) rescue $!
      end

      context 'with a Float' do
        let(:arg){ 12.0 }

        it 'should raise an Error' do
          expect(subject).to be_a(TypeError)
          expect(subject.message).to eq("Invalid value `12.0` for byte")
        end

        it "should have the proper cause from super type's up" do
          expect(subject.cause).to be_a(TypeError)
          expect(subject.cause.message).to eq("Invalid value `12.0` for intType")
        end

        it "should have an empty location" do
          expect(subject.location).to eq('')
        end
      end

      context 'with a negative integer' do
        let(:arg){ -12 }

        it 'should raise an Error' do
          expect(subject).to be_a(TypeError)
          expect(subject.message).to eq("Invalid value `-12` for byte")
        end

        it "should have no cause" do
          expect(subject.cause).to be_nil
        end

        it "should have an empty location" do
          expect(subject.location).to eq('')
        end
      end

      context 'with a non small integer' do
        let(:arg){ 1000 }

        it 'should raise an Error' do
          expect(subject).to be_a(TypeError)
          expect(subject.message).to eq("Invalid value `1000` for byte")
        end

        it "should have no cause" do
          expect(subject.cause).to be_nil
        end

        it "should have an empty location" do
          expect(subject.location).to eq('')
        end
      end
    end

  end
end
