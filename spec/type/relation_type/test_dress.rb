require 'spec_helper'
module Finitio
  describe RelationType, "dress" do

    let(:heading){
      Heading.new([Attribute.new(:r, byte),
                   Attribute.new(:g, byte),
                   Attribute.new(:b, byte)])
    }

    let(:type){
      RelationType.new(heading, "colors")
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
          expect(subject.message).to eq("Invalid value `foo` for colors")
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
          expect(subject.message).to eq("Invalid value `foo` for {r: Byte, g: Byte, b: Byte}")
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
            { "r" => 12, "g" => 13 }
          ]
        }

        it 'should raise a TypeError' do
          expect(subject).to be_a(TypeError)
          expect(subject.message).to eq("Missing attribute `b`")
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
          expect(subject.message).to eq("Invalid value `12.0` for Byte")
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