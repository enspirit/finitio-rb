require 'spec_helper'
module Qrb
  describe AnyType, "default_name" do

    let(:type){ AnyType.new }

    it 'uses Any' do
      type.default_name.should eq("Any")
    end

  end
end
