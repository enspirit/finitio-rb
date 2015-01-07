require 'spec_helper'
module Finitio
  describe TypeFactory, "Factory#tuple" do

    let(:factory){ TypeFactory.new }

    let(:expected){ factory.tuple(r: Integer) }

    context 'when use with {r: Integer}' do
      subject{ factory.type(r: Integer) }

      it{ should eq(expected) }
    end

    context 'when use with {r: Integer} and a name' do
      subject{ factory.type({r: Integer}, "MyTuple") }

      it{ should eq(expected) }

      it 'should have the correct name' do
        expect(subject.name).to eq("MyTuple")
      end
    end

    context 'when use with {r: 0..255} and a name' do
      subject{ factory.type({r: 0..255}, "MyTuple") }

      it{ should be_a(TupleType) }

      it 'should have the correct constraint on r' do
        subject.dress(r: 36)
        expect{
          subject.dress(r: 543)
        }.to raise_error(TypeError)
      end

      it 'should have the correct name' do
        expect(subject.name).to eq("MyTuple")
      end
    end

  end
end
