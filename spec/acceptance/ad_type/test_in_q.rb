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

    let(:system) do
      Qrb.parse <<-EOF
        Byte   = .Fixnum( i | i>=0 and i<= 255 )
        Color  = .Qrb::MyColorClass <rgb> {r: Byte, g: Byte, b: Byte}
        Gender = <mf> .String( s | s=='M' or s=='F' )
      EOF
    end

    let(:color){
      system["Color"]
    }

    describe 'the Color.dress method' do
      subject{ color.dress(arg) }

      context 'when valid' do
        let(:arg){ {"r" => 12, "g" => 17, "b" => 71} }

        it{ should be_a(MyColorClass) }

        it 'should be the expected one' do
          subject.r.should eq(12)
          subject.g.should eq(17)
          subject.b.should eq(71)
        end
      end

      context 'when invalid' do
        let(:arg){ {"r" => -12, "g" => 17, "b" => 71} }

        it 'should raise an error' do
          ->{
            subject
          }.should raise_error(TypeError)
        end
      end

    end

    describe 'the Gender.dress method' do
      subject{ system['Gender'].dress(arg) }

      context 'when valid' do
        let(:arg){ 'M' }

        it{ should eq('M') }
      end

      context 'when valid' do
        let(:arg){ 'Monsieur' }

        it 'should raise an error' do
          ->{
            subject
          }.should raise_error(TypeError, "Invalid value `Monsieur` for Gender")
        end
      end
    end

  end
end