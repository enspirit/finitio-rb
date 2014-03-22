require 'spec_helper'
module Finitio
  describe MultiRelationType, "default_name" do

    let(:heading){
      Heading.new([
        Attribute.new(:a, byte),
        Attribute.new(:b, byte, false)
      ])
    }

    subject{ type.default_name }

    let(:type){ MultiRelationType.new(heading) }

    it{ should eq("{{a: Byte, b :? Byte}}") }

  end
end
