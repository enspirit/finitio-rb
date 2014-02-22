require 'spec_helper'
module Qrb
  describe "Using Q's abstract data types in Ruby/Q" do

    class MyColorClass
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
    end

    let(:realm) do
      Qrb.parse_realm <<-EOF
        Byte  = .Fixnum( i | i>=0 and i<= 255 )
        Color = .Qrb::MyColorClass <rgb> {r: Byte, g: Byte, b: Byte}
      EOF
    end

    let(:color){
      realm["Color"]
    }

    describe 'the Color.from_q method' do
      subject{ color.from_q(arg) }

      context 'when valid' do
        let(:arg){ {"r" => 12, "g" => 17, "b" => 71} }

        it{ should be_a(MyColorClass) }

        it 'should be the expected one' do
          subject.r.should eq(12)
          subject.g.should eq(17)
          subject.b.should eq(71)
        end
      end

    end

  end
end