require 'spec_helper'
module Qrb
  describe RelationType, "initialize" do

    let(:heading){
      Heading.new([Attribute.new(:a, intType)])
    }

    context 'with a valid heading' do
      subject{ RelationType.new("relType", heading) }

      it{ should be_a(RelationType) }
    end

    context 'with an invalid heading' do
      subject{ RelationType.new("foo", "bar") }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(ArgumentError, "Heading expected, got `bar`")
      end
    end

  end
end