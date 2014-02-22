require 'spec_helper'
module Qrb
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
        subject.name.should eq("MyTuple")
      end
    end

    context 'when use with {r: 0..255} and a name' do
      subject{ factory.type({r: 0..255}, "MyTuple") }

      it{ should be_a(TupleType) }

      it 'should have the correct constraint on r' do
        subject.from_q(r: 36)
        ->{
          subject.from_q(r: 543)
        }.should raise_error(UpError)
      end

      it 'should have the correct name' do
        subject.name.should eq("MyTuple")
      end
    end

  end
end
