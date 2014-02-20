require 'spec_helper'
module Qrb
  describe TupleType, "name" do

    let(:heading){
      Heading.new([Attribute.new(:a, byte)])
    }

    subject{ type.name }

    context 'when not provided' do
      let(:type){ TupleType.new(heading) }

      it{ should eq("{a: Byte}") }
    end

    context 'when provided' do
      let(:type){ TupleType.new(heading, "Color") }

      it{ should eq("Color") }
    end

  end
end
