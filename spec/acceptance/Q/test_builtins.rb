require 'spec_helper'
module Qrb
  describe "Q/builtins" do

    let(:realm){ Qrb.realm('Q/builtins') }

    describe 'Boolean' do
      let(:type){ realm['Boolean'] }

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
      let(:type){ realm['Date'] }

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

  end
end
