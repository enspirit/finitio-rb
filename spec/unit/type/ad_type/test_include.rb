require 'spec_helper'
module Finitio
  describe AdType, "include?" do

    let(:type){ AdType.new(Color, {}) }

    subject{ type.include?(arg) }

    context 'when not included' do
      let(:arg){ "12" }

      it{ should be_false }
    end

    context 'when included' do
      let(:arg){ blueviolet }

      it{ should be_true }
    end

  end
end
