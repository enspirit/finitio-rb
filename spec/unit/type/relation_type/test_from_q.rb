require 'spec_helper'
module Qrb
  describe RelationType, "from_q" do

    let(:heading){
      Heading.new([Attribute.new(:r, byte),
                   Attribute.new(:g, byte),
                   Attribute.new(:b, byte)])
    }

    let(:type){
      RelationType.new(heading, "colors")
    }

    subject{ type.from_q(arg)  }

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

    context 'when raising an error' do

      subject do
        type.from_q(arg) rescue $!
      end

      context 'with something else than an Array' do
        let(:arg){
          "foo"
        }

        it 'should raise an TypeError' do
          subject.should be_a(TypeError)
          subject.message.should eq("Invalid value `foo` for colors")
        end

        it 'should have no cause' do
          subject.cause.should be_nil
        end

        it 'should have an empty location' do
          subject.location.should eq('')
        end
      end

      context 'with Array of non-tuples' do
        let(:arg){
          ["foo"]
        }

        it 'should raise an TypeError' do
          subject.should be_a(TypeError)
          subject.message.should eq("Invalid value `foo` for {r: Byte, g: Byte, b: Byte}")
        end

        it 'should have no cause' do
          subject.cause.should be_nil
        end

        it 'should have the correct location' do
          subject.location.should eq('0')
        end
      end

      context 'with a wrong tuple' do
        let(:arg){
          [
            { "r" => 12, "g" => 13, "b" => 255 },
            { "r" => 12, "g" => 13 }
          ]
        }

        it 'should raise an TypeError' do
          subject.should be_a(TypeError)
          subject.message.should eq("Missing attribute `b`")
        end

        it 'should have no cause' do
          subject.cause.should be_nil
        end

        it 'should have the correct location' do
          subject.location.should eq('1')
        end
      end

      context 'with a wrong tuple attribute' do
        let(:arg){
          [
            { "r" => 12, "g" => 13, "b" => 255  },
            { "r" => 12, "g" => 13, "b" => 12.0 }
          ]
        }

        it 'should raise an TypeError' do
          subject.should be_a(TypeError)
          subject.message.should eq("Invalid value `12.0` for Byte")
        end

        it 'should have a cause' do
          subject.cause.should_not be_nil
        end

        it 'should have the correct location' do
          subject.location.should eq('1/b')
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

        it 'should raise an TypeError' do
          subject.should be_a(TypeError)
          subject.message.should eq("Duplicate tuple")
        end

        it 'should have no cause' do
          subject.cause.should be_nil
        end

        it 'should have the correct location' do
          subject.location.should eq('2')
        end
      end
    end

  end
end