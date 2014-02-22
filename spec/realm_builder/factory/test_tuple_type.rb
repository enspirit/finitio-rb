require 'spec_helper'
module Qrb
  describe RealmBuilder, "Factory#tuple" do

    let(:builder){ RealmBuilder.new }

    let(:expected){ builder.tuple(r: Integer) }

    context 'when use with {r: Integer}' do
      subject{ builder.type(r: Integer) }

      it{ should eq(expected) }
    end

    context 'when use with {r: Integer} and a name' do
      subject{ builder.type({r: Integer}, "MyTuple") }

      it{ should eq(expected) }

      it 'should have the correct name' do
        subject.name.should eq("MyTuple")
      end
    end

  end
end
