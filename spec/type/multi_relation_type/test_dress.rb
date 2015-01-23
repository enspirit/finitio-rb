require 'spec_helper'
module Finitio
  describe MultiRelationType, "dress" do

    let(:heading){
      Heading.new([Attribute.new(:r, byte),
                   Attribute.new(:g, byte),
                   Attribute.new(:b, byte, false)])
    }

    let(:type){
      MultiRelationType.new(heading, "colors")
    }

    subject{ type.dress(arg)  }

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
        expect(subject).to be_a(Enumerable)
        expect(subject.to_a).to eq(expected)
      end
    end

    context 'with a valid array of Hashes with some optional missing' do
      let(:arg){
        [
          { "r" => 12, "g" => 13, "b" => 255 },
          { "r" => 12, "g" => 15 }
        ]
      }
      let(:expected){
        [
          { r: 12, g: 13, b: 255 },
          { r: 12, g: 15 }
        ]
      }

      it 'should coerce to an Enumerable of tuples' do
        expect(subject).to be_a(Enumerable)
        expect(subject.to_a).to eq(expected)
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
        expect(subject).to be_a(Enumerable)
        expect(subject.to_a).to eq(expected)
      end
    end

    context 'when raising an error' do

      subject do
        type.dress(arg) rescue $!
      end

      context 'with something else than an Array' do
        let(:arg){
          "foo"
        }

        it 'should raise a TypeError' do
          expect(subject).to be_a(TypeError)
          expect(subject.message).to eq("Invalid colors `foo`")
        end

        it 'should have no cause' do
          expect(subject.cause).to be_nil
        end

        it 'should have an empty location' do
          expect(subject.location).to eq('')
        end
      end

      context 'with Array of non-tuples' do
        let(:arg){
          ["foo"]
        }

        it 'should raise a TypeError' do
          expect(subject).to be_a(TypeError)
          expect(subject.message).to eq("Invalid {r: Byte, g: Byte, b :? Byte} `foo`")
        end

        it 'should have no cause' do
          expect(subject.cause).to be_nil
        end

        it 'should have the correct location' do
          expect(subject.location).to eq('0')
        end
      end

      context 'with a wrong tuple' do
        let(:arg){
          [
            { "r" => 12, "g" => 13, "b" => 255 },
            { "r" => 12, "b" => 13 }
          ]
        }

        it 'should raise a TypeError' do
          expect(subject).to be_a(TypeError)
          expect(subject.message).to eq("Missing attribute `g`")
        end

        it 'should have no cause' do
          expect(subject.cause).to be_nil
        end

        it 'should have the correct location' do
          expect(subject.location).to eq('1')
        end
      end

      context 'with a tuple with extra attribute' do
        let(:arg){
          [
            { "r" => 12, "g" => 13, "b" => 255 },
            { "r" => 12, "g" => 13, "f" => 13 }
          ]
        }

        it 'should raise a TypeError' do
          expect(subject).to be_a(TypeError)
          expect(subject.message).to eq("Unrecognized attribute `f`")
        end

        it 'should have no cause' do
          expect(subject.cause).to be_nil
        end

        it 'should have the correct location' do
          expect(subject.location).to eq('1')
        end
      end

      context 'with a wrong tuple attribute' do
        let(:arg){
          [
            { "r" => 12, "g" => 13, "b" => 255  },
            { "r" => 12, "g" => 13, "b" => 12.0 }
          ]
        }

        it 'should raise a TypeError' do
          expect(subject).to be_a(TypeError)
          expect(subject.message).to eq("Invalid Byte `12.0`")
        end

        it 'should have a cause' do
          expect(subject.cause).not_to be_nil
        end

        it 'should have the correct location' do
          expect(subject.location).to eq('1/b')
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

        it 'should raise a TypeError' do
          expect(subject).to be_a(TypeError)
          expect(subject.message).to eq("Duplicate tuple")
        end

        it 'should have no cause' do
          expect(subject.cause).to be_nil
        end

        it 'should have the correct location' do
          expect(subject.location).to eq('2')
        end
      end
    end

  end
end