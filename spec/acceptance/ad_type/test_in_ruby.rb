require 'spec_helper'
module Qrb
  describe "Using Q's abstract data types in Ruby" do

    let(:color) do
      Class.new{
        extend Qrb::DataType

        def initialize(r, g, b)
          @r, @g, @b = r, g, b
        end
        attr_reader :r, :g, :b

        def to_rgb
          { r: @r, g: @g, b: @b }
        end

        def self.rgb(tuple)
          new(tuple[:r], tuple[:g], tuple[:b])
        end

        contract :rgb, {r: 0..255, g: 0..255, b: 0..255}
      }
    end

    describe 'The factored class' do
      subject{ color }

      it{ should be_a(Class) }
    end

    describe 'the dress method, when valid' do

      subject{
        color.dress(r: 12, g: 13, b: 28)
      }

      it{ should be_a(color) }

      it 'should set the instance variables correctly' do
        subject.r.should eq(12)
        subject.g.should eq(13)
        subject.b.should eq(28)
      end
    end

    describe 'the up method, when already a color' do
      let(:value){
        color.new(12, 13, 28)
      }

      subject{
        color.dress(value)
      }

      it{ should be(value) }
    end

  end
end
