require 'spec_helper'
module Qrb
  describe System, "initialize" do

    subject{ System.new }

    it{ should be_a(System) }

  end
end
