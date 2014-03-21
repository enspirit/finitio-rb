require 'spec_helper'
module Finitio
  describe MultiTupleType, "default_name" do

    let(:heading){
      Heading.new([
        Attribute.new(:a, byte, true),
        Attribute.new(:b, byte, false)
      ])
    }

    subject{ MultiTupleType.new(heading).default_name }

    it{ should eq("{a: Byte, b :? Byte}") }

  end
end
