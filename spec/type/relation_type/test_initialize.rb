require 'spec_helper'
module Finitio
  describe RelationType, "initialize" do

    let(:heading){
      Heading.new([Attribute.new(:a, intType)])
    }

    context 'with a valid heading' do
      subject{ RelationType.new(heading) }

      it{ should be_a(RelationType) }
    end

    context 'with an invalid heading' do
      subject{ RelationType.new("foo", "bar") }

      it 'should raise an error' do
        expect{
          subject
        }.to raise_error(ArgumentError, "Heading expected, got `foo`")
      end
    end

  end
end
