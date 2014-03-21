require 'spec_helper'
module Finitio
  describe Attribute, "to_name" do

    subject{ attr.to_name }

    context 'when required' do
      let(:attr){ Attribute.new(:red, intType) }

      it{ should eq("red: intType") }
    end

    context 'when not required' do
      let(:attr){ Attribute.new(:red, intType, false) }

      it{ should eq("red :? intType") }
    end

  end
end
