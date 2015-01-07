require 'spec_helper'
module Finitio
  describe AnyType, "include?" do

    let(:type){ AnyType.new }

    subject{ type.include?(arg) }

    context 'with nil' do
      let(:arg){ nil }

      it{ should eq(true) }
    end

    context 'when an Integer' do
      let(:arg){ 12 }

      it{ should eq(true) }
    end

  end
end
