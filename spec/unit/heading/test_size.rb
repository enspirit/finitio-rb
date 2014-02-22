require 'spec_helper'
module Qrb
  describe Heading, "size" do

    let(:r){ Attribute.new(:red, intType) }
    let(:g){ Attribute.new(:green, intType) }
    let(:b){ Attribute.new(:blue, intType) }

    subject{ heading.size }

    context 'on an empty heading' do
      let(:heading){ Heading.new([]) }

      it{ should eq(0) }
    end

    context 'on an singleton heading' do
      let(:heading){ Heading.new([r]) }

      it{ should eq(1) }
    end

    context 'on an big heading' do
      let(:heading){ Heading.new([r, g, b]) }

      it{ should eq(3) }
    end

  end
end