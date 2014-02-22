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

  end
end
