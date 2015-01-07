require 'spec_helper'
module Finitio
  describe MultiRelationType, "initialize" do

    let(:heading){
      Heading.new([
        Attribute.new(:a, intType),
        Attribute.new(:b, intType, false)
      ])
    }

    context 'with a valid heading' do
      subject{ MultiRelationType.new(heading) }

      it{ should be_a(MultiRelationType) }
    end

    context 'with an invalid heading' do
      subject{ MultiRelationType.new("foo", "bar") }

      it 'should raise an error' do
        expect{
          subject
        }.to raise_error(ArgumentError, "Heading expected, got `foo`")
      end
    end

  end
end
