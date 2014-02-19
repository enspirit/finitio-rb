require 'spec_helper'
module Qrb
  describe Heading, "initialize" do

    subject{ Heading.new([ Attribute.new(:red, intType) ]) }

    it{ should be_a(Heading) }

  end
end