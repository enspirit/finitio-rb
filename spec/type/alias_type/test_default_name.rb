require 'spec_helper'
module Finitio
  describe AliasType, "default_name" do

    let(:type){ AliasType.new(intType, 'Alias') }

    it{ type.default_name.should eq('Alias') }

  end
end
