require 'spec_helper'
module Finitio
  describe StructType, "dress" do

    let(:type){
      StructType.new([intType, floatType], "point")
    }

    subject{ type.dress(arg)  }

    context 'with a valid Array' do
      let(:arg){
        [ 12, 14.0 ]
      }

      it 'should coerce to an array' do
        subject.should eq(arg)
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
          subject.should be_a(TypeError)
          subject.message.should eq("Invalid value `foo` for point")
        end

        it 'should have no cause' do
          subject.cause.should be_nil
        end

        it 'should have an empty location' do
          subject.location.should eq('')
        end
      end

      context 'with a missing component' do
        let(:arg){
          [ 12 ]
        }

        it 'should raise a TypeError' do
          subject.should be_a(TypeError)
          subject.message.should eq("Struct size mismatch (1 for 2)")
        end

        it 'should have no cause' do
          subject.cause.should be_nil
        end

        it 'should have an empty location' do
          subject.location.should eq('')
        end
      end

      context 'with an extra attribute' do
        let(:arg){
          [ 12, 14.0, "bar" ]
        }

        it 'should raise a TypeError' do
          subject.should be_a(TypeError)
          subject.message.should eq("Struct size mismatch (3 for 2)")
        end

        it 'should have no cause' do
          subject.cause.should be_nil
        end

        it 'should have an empty location' do
          subject.location.should eq('')
        end
      end

      context 'with an invalid attribute' do
        let(:arg){
          [ 12, "bar" ]
        }

        it 'should raise a TypeError' do
          subject.should be_a(TypeError)
          subject.message.should eq("Invalid value `bar` for floatType")
        end

        it 'should have no cause' do
          subject.cause.should be_nil
        end

        it 'should have the correct location' do
          subject.location.should eq("1")
        end
      end
    end

  end
end