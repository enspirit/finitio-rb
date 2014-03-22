require 'spec_helper'
module Finitio
  describe MultiRelationType, "name" do

    let(:heading){
      Heading.new([
        Attribute.new(:a, byte),
        Attribute.new(:b, byte, false)
      ])
    }

    subject{ type.name }

    context 'when not provided' do
      let(:type){ MultiRelationType.new(heading) }

      it{ should eq("{{a: Byte, b :? Byte}}") }
    end

    context 'when provided' do
      let(:type){ MultiRelationType.new(heading, "colors") }

      it{ should eq("colors") }
    end

  end
end
