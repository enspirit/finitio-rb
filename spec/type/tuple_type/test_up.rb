require 'spec_helper'
module Qrb
  describe TupleType, "up" do

    let(:byte){
      SubType.new("byte", intType, predicate: ->(i){ i>=0 && i<=255 })
    }

    let(:heading){
      Heading.new([Attribute.new(:r, byte),
                   Attribute.new(:g, byte),
                   Attribute.new(:b, byte)])
    }

    let(:type){
      TupleType.new("color", heading)
    }

    subject{ type.up(arg)  }

    context 'with a valid Hash' do
      let(:arg){
        { "r" => 12, "g" => 13, "b" => 255 }
      }

      it 'should coerce to a tuple' do
        subject.should eq(r: 12, g: 13, b: 255)
      end
    end

    context 'with something else than a Hash' do
      let(:arg){
        "foo"
      }

      it 'should raise an UpError' do
        ->{
          subject
        }.should raise_error(UpError, "Invalid value `foo` for color")
      end
    end

    context 'with a missing attribute' do
      let(:arg){
        { "r" => 12, "g" => 13 }
      }

      it 'should raise an UpError' do
        ->{
          subject
        }.should raise_error(UpError, "Missing attribute `b`")
      end
    end

    context 'with an extra attribute' do
      let(:arg){
        { "r" => 12, "g" => 13, "b" => 255, "extr" => 165 }
      }

      it 'should raise an UpError' do
        ->{
          subject
        }.should raise_error(UpError, "Unrecognized attribute `extr`")
      end
    end

    context 'with an invalid attribute' do
      let(:arg){
        { "r" => 12.0, "g" => 13, "b" => 255 }
      }

      it 'should raise an UpError' do
        ->{
          subject
        }.should raise_error(UpError, "Invalid value `12.0` for byte")
      end

      it 'should have the correct cause' do
        begin
          subject
          raise
        rescue UpError => ex
          ex.cause.should be_a(UpError)
          ex.cause.message.should eq("Invalid value `12.0` for intType")
        end
      end
    end

  end
end