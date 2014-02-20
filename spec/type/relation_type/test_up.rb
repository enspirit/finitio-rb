require 'spec_helper'
module Qrb
  describe RelationType, "up" do

    let(:byte){
      SubType.new("byte", intType, predicate: ->(i){ i>=0 && i<=255 })
    }

    let(:heading){
      Heading.new([Attribute.new(:r, byte),
                   Attribute.new(:g, byte),
                   Attribute.new(:b, byte)])
    }

    let(:type){
      RelationType.new("colors", heading)
    }

    subject{ type.up(arg)  }

    context 'with a valid array of Hashes' do
      let(:arg){
        [
          { "r" => 12, "g" => 13, "b" => 255 },
          { "r" => 12, "g" => 15, "b" => 198 }
        ]
      }
      let(:expected){
        [
          { r: 12, g: 13, b: 255 },
          { r: 12, g: 15, b: 198 }
        ]
      }

      it 'should coerce to an Enumerable of tuples' do
        subject.should be_a(Enumerable)
        subject.to_a.should eq(expected)
      end
    end

    context 'with an empty array' do
      let(:arg){
        []
      }
      let(:expected){
        []
      }

      it 'should coerce to an Enumerable of tuples' do
        subject.should be_a(Enumerable)
        subject.to_a.should eq(expected)
      end
    end

    context 'with something else than an Array' do
      let(:arg){
        "foo"
      }

      it 'should raise an UpError' do
        ->{
          subject
        }.should raise_error(UpError, "Invalid value `foo` for colors")
      end
    end

    context 'with Array of non-tuples' do
      let(:arg){
        ["foo"]
      }

      it 'should raise an UpError' do
        ->{
          subject
        }.should raise_error(UpError, "Invalid value `foo` for colors")
      end
    end

    context 'with a wrong tuple' do
      let(:arg){
        [
          { "r" => 12, "g" => 13, "b" => 255 },
          { "r" => 12, "g" => 13 }
        ]
      }

      it 'should raise an UpError' do
        ->{
          subject
        }.should raise_error(UpError, %Q{Missing attribute `b`})
      end
    end

    context 'with a duplicate tuple' do
      let(:arg){
        [
          { "r" => 12, "g" => 13, "b" => 255 },
          { "r" => 12, "g" => 192, "b" => 13 },
          { "r" => 12, "g" => 13, "b" => 255 }
        ]
      }

      it 'should raise an UpError' do
        ->{
          subject
        }.should raise_error(UpError, "Duplicate tuple")
      end
    end

  end
end