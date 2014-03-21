require 'spec_helper'
module Finitio
  describe MultiTupleType, "name" do

    let(:heading){
      Heading.new([Attribute.new(:a, byte, false)])
    }

    subject{ type.name }

    context 'when not provided' do
      let(:type){ MultiTupleType.new(heading) }

      it{ should eq("{a :? Byte}") }
    end

    context 'when provided' do
      let(:type){ MultiTupleType.new(heading, "Color") }

      it{ should eq("Color") }
    end

  end
end
