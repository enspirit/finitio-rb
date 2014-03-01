require 'spec_helper'
module Qrb
  describe "Q/default" do

    let(:system){ Qrb.system('Q/default') }

    describe 'Boolean' do
      let(:type){ system['Boolean'] }

      it 'recognizes true' do
        type.dress(true).should eq(true)
      end

      it 'recognizes false' do
        type.dress(false).should eq(false)
      end

      it 'raises on something else' do
        ->{ type.dress("foo") }.should raise_error(TypeError)
      end
    end

    describe 'Date' do
      let(:type){ system['Date'] }

      let(:expected){ Date.new(2014, 11, 9) }

      it 'recognizes dates' do
        type.dress(expected).should be(expected)
      end

      it 'recognizes iso8601 dates' do
        type.dress('2014-11-09').should eq(expected)
      end

      it 'recognizes the output of iso8601' do
        type.dress(expected.iso8601).should eq(expected)
      end

      it 'raises on something else' do
        ->{
          type.dress('foo')
        }.should raise_error("Invalid value `foo` for Date")
      end
    end

    describe 'Time' do
      let(:type){ system['Time'] }

      let(:expected){ Time.new(2014,3,1,12,9,31) }

      it 'recognizes times' do
        type.dress(expected).should be(expected)
      end

      it 'recognizes iso8601 times' do
        type.dress('2014-03-01T12:09:31').should eq(expected)
      end

      it 'recognizes the output of iso8601' do
        type.dress(expected.iso8601).should eq(expected)
      end

      it 'raises on something else' do
        ->{
          type.dress('foo')
        }.should raise_error("Invalid value `foo` for Time")
      end
    end

    describe 'DateTime' do
      let(:type){ system['DateTime'] }

      let(:expected){ DateTime.new(2014,3,1,12,9,31) }

      it 'recognizes times' do
        type.dress(expected).should be(expected)
      end

      it 'recognizes iso8601 times' do
        type.dress('2014-03-01T12:09:31').should eq(expected)
      end

      it 'recognizes the output of iso8601' do
        type.dress(expected.iso8601).should eq(expected)
      end

      it 'raises on something else' do
        ->{
          type.dress('foo')
        }.should raise_error("Invalid value `foo` for DateTime")
      end
    end

  end
end
