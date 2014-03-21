require 'spec_helper'
module Finitio
  describe Attribute, "to_name" do

    subject{ Attribute.new(:red, intType).to_name }

    it{ should eq("red: intType") }

  end
end
