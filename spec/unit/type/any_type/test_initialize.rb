require 'spec_helper'
module Finitio
  describe AnyType, "initialize" do

    let(:type){ AnyType.new }

    it{ should be_a(AnyType) }

  end
end
