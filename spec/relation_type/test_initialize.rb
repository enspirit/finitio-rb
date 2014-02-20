require 'spec_helper'
module Qrb
  describe RelationType, "initialize" do

    let(:heading){
      Heading.new([Attribute.new(:a, intType)])
    }

    subject{ RelationType.new("relType", heading) }

    it{ should be_a(RelationType) }

  end
end