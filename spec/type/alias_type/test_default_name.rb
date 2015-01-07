require 'spec_helper'
module Finitio
  describe AliasType, "default_name" do

    let(:type){ AliasType.new(intType, 'Alias') }

    it{ expect(type.default_name).to eq('Alias') }

  end
end
