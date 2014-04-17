require 'spec_helper'
module Finitio
  describe SubType, "default_name" do

    let(:type){ SubType.new(intType, [positive]) }

    subject{ type.default_name }

    it 'uses the first constraint name' do
      subject.should eq("Positive")
    end

  end
end
