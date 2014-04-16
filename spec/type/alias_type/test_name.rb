require 'spec_helper'
module Finitio
  describe AliasType, "name" do

    let(:type){ AliasType.new(intType, 'Alias') }

    it{ type.name.should eq('Alias') }

  end
end
