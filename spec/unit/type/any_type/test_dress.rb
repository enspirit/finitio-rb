require 'spec_helper'
module Qrb
  describe AnyType, "dress" do

    let(:type){ AnyType.new }

    subject{ type.dress(arg) }

    context 'with nil' do
      let(:arg){ nil }

      it{ should be(arg) }
    end

    context 'with a Float' do
      let(:arg){ 12.0 }

      it{ should be(arg) }
    end

  end
end
