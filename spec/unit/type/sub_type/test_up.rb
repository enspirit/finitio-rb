require 'spec_helper'
module Qrb
  describe SubType, "up" do

    let(:type){ SubType.new(intType, {default: ->(i){ i>0 }, small: ->(i){ i<255 }}, "byte") }

    subject{ type.up(arg) }

    context 'with an valid Integer' do
      let(:arg){ 12 }

      it{ should be(arg) }
    end

    context 'when raising an Error' do

      subject do
        begin
          type.up(arg)
          raise
        rescue => ex
          ex
        end
      end

      context 'with a Float' do
        let(:arg){ 12.0 }

        it 'should raise an Error' do
          subject.should be_a(UpError)
          subject.message.should eq("Invalid value `12.0` for byte")
        end

        it "should have the proper cause from super type's up" do
          subject.cause.should be_a(UpError)
          subject.cause.message.should eq("Invalid value `12.0` for intType")
        end

        it "should have an empty location" do
          subject.location.should eq('')
        end
      end

      context 'with a negative integer' do
        let(:arg){ -12 }

        it 'should raise an Error' do
          subject.should be_a(UpError)
          subject.message.should eq("Invalid value `-12` for byte")
        end

        it "should have no cause" do
          subject.cause.should be_nil
        end

        it "should have an empty location" do
          subject.location.should eq('')
        end
      end

      context 'with a non small integer' do
        let(:arg){ 1000 }

        it 'should raise an Error' do
          subject.should be_a(UpError)
          subject.message.should eq("Invalid value `1000` for byte (not small)")
        end

        it "should have no cause" do
          subject.cause.should be_nil
        end

        it "should have an empty location" do
          subject.location.should eq('')
        end
      end
    end

  end
end
