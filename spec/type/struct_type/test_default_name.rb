require 'spec_helper'
module Finitio
  describe StructType, "default_name" do

    subject{ StructType.new([intType, floatType]).default_name }

    it{ should eq("<intType, floatType>") }

  end
end
