require 'spec_helper'
module Qrb
  describe RelationType, "default_name" do

    let(:heading){
      Heading.new([Attribute.new(:a, byte)])
    }

    subject{ type.default_name }

    let(:type){ RelationType.new(heading) }

    it{ should eq("{{a: Byte}}") }

  end
end
