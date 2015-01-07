require 'spec_helper'
module Finitio
  describe Attribute, "fetch_on" do

    let(:attr){ Attribute.new(:red, intType) }

    subject{ attr.fetch_on(arg) }

    context 'with an object that does not support fetch' do
      let(:arg){ 12 }

      it 'should raise an error' do
        expect{
          subject
        }.to raise_error(ArgumentError, "Object responding to `fetch` expected")
      end
    end

    context 'with a hash with symbol keys' do
      let(:arg){ { red: 233 } }

      it{ should eq(233) }
    end

    context 'with a hash with string keys' do
      let(:arg){ { "red" => 233 } }

      it{ should eq(233) }
    end

    context 'when the key is missing and no block' do
      let(:arg){ { other: 123 } }

      it 'should raise an error' do
        expect{
          attr.fetch_on(arg)
        }.to raise_error(KeyError)
      end
    end

    context 'when the key is missing and a block' do
      let(:arg){ { other: 123 } }

      it 'should yield the block' do
        expect(attr.fetch_on(arg){ "none" }).to eq("none")
      end
    end

  end
end
