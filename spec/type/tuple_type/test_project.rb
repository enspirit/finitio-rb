require 'spec_helper'
module Finitio
  describe TupleType, "project" do

    let(:h1){ Heading.new([Attribute.new(:r, intType), Attribute.new(:b, intType)]) }
    let(:h2){ Heading.new([Attribute.new(:b, intType)]) }

    let(:t1)  { TupleType.new(h1) }
    let(:t2)  { TupleType.new(h2) }

    it 'removes unwanted atributes' do
      expect(t1.project([:b])).to eql(t2)
    end


  end
end
