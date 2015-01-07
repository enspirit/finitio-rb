require 'spec_helper'
module Finitio
  describe AdType, "include?" do

    let(:type){ AdType.new(Color, []) }

    subject{ type.include?(arg) }

    context 'when not included' do
      let(:arg){ "12" }

      it{ should eq(false) }
    end

    context 'when included' do
      let(:arg){ blueviolet }

      it{ should eq(true) }
    end

  end
end
