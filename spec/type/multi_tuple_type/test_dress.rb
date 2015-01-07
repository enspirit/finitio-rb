require 'spec_helper'
module Finitio
  describe MultiTupleType, "dress" do

    let(:r)      { Attribute.new(:r, byte)        }
    let(:g)      { Attribute.new(:g, byte)        }
    let(:maybe_b){ Attribute.new(:b, byte, false) }

    let(:type){
      MultiTupleType.new(heading, "color")
    }

    subject{ type.dress(arg)  }

    context 'when not allowing extra' do
      let(:heading){
        Heading.new([r, g, maybe_b])
      }

      context 'with a valid Hash' do
        let(:arg){
          { "r" => 12, "g" => 13, "b" => 255 }
        }

        it 'should coerce to a tuple' do
          expect(subject).to eq(r: 12, g: 13, b: 255)
        end
      end

      context 'with a valid Hash and no optional' do
        let(:arg){
          { "r" => 12, "g" => 13 }
        }

        it 'should coerce to a tuple' do
          expect(subject).to eq(r: 12, g: 13)
        end
      end

      context 'when raising an error' do

        subject do
          type.dress(arg) rescue $!
        end

        context 'with something else than a Hash' do
          let(:arg){
            "foo"
          }

          it 'should raise a TypeError' do
            expect(subject).to be_a(TypeError)
            expect(subject.message).to eq("Invalid value `foo` for color")
          end

          it 'should have no cause' do
            expect(subject.cause).to be_nil
          end

          it 'should have an empty location' do
            expect(subject.location).to eq('')
          end
        end

        context 'with a missing attribute' do
          let(:arg){
            { "r" => 12, "b" => 13 }
          }

          it 'should raise a TypeError' do
            expect(subject).to be_a(TypeError)
            expect(subject.message).to eq("Missing attribute `g`")
          end

          it 'should have no cause' do
            expect(subject.cause).to be_nil
          end

          it 'should have an empty location' do
            expect(subject.location).to eq('')
          end
        end

        context 'with an extra attribute' do
          let(:arg){
            { "r" => 12, "g" => 13, "extr" => 165 }
          }

          it 'should raise a TypeError' do
            expect(subject).to be_a(TypeError)
            expect(subject.message).to eq("Unrecognized attribute `extr`")
          end

          it 'should have no cause' do
            expect(subject.cause).to be_nil
          end

          it 'should have an empty location' do
            expect(subject.location).to eq('')
          end
        end

        context 'with an invalid attribute' do
          let(:arg){
            { "r" => 12, "g" => 13, "b" => 255.0 }
          }

          it 'should raise a TypeError' do
            expect(subject).to be_a(TypeError)
            expect(subject.message).to eq("Invalid value `255.0` for Byte")
          end

          it 'should have the correct cause' do
            expect(subject.cause).to be_a(TypeError)
            expect(subject.cause.message).to eq("Invalid value `255.0` for intType")
          end

          it 'should have the correct location' do
            expect(subject.location).to eq("b")
          end
        end
      end
    end

    context 'when not allowing extra' do
      let(:heading){
        Heading.new([r, g, maybe_b], allow_extra: true)
      }

      context 'with an extra attribute' do
        let(:arg){
          { "r" => 12, "g" => 13, "extr" => 165 }
        }

        it 'should not raise a TypeError' do
          expect(subject).not_to be_a(TypeError)
        end

        it 'should return a coerced/projection' do
          expect(subject).to eq(r: 12, g: 13)
        end
      end
    end

  end
end