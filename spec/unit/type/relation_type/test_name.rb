require 'spec_helper'
module Qrb
  describe RelationType, "name" do

    let(:heading){
      Heading.new([Attribute.new(:a, byte)])
    }

    subject{ type.name }

    context 'when not provided' do
      let(:type){ RelationType.new(heading) }

      it{ should eq("{{a: Byte}}") }
    end

    context 'when provided' do
      let(:type){ RelationType.new(heading, "colors") }

      it{ should eq("colors") }
    end

  end
end
