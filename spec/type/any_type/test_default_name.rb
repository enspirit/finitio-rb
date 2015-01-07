require 'spec_helper'
module Finitio
  describe AnyType, "default_name" do

    let(:type){ AnyType.new }

    it 'uses Any' do
      expect(type.default_name).to eq("Any")
    end

  end
end
