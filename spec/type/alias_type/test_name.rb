require 'spec_helper'
module Finitio
  describe AliasType, "name" do

    let(:type){ AliasType.new(intType, 'Alias') }

    it{ expect(type.name).to eq('Alias') }

  end
end
