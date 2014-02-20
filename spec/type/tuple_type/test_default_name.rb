require 'spec_helper'
module Qrb
  describe TupleType, "default_name" do

    let(:heading){
      Heading.new([Attribute.new(:a, byte)])
    }

    subject{ TupleType.new(heading).default_name }

    it{ should eq("{a: Byte}") }

  end
end
