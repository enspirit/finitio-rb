require 'spec_helper'
module Qrb
  describe BuiltinType, "include?" do

    let(:type){ BuiltinType.new(Integer) }

    subject{ type.include?(arg) }

    context 'when not included' do
      let(:arg){ "12" }

      it{ should be_false }
    end

    context 'when included' do
      let(:arg){ 12 }

      it{ should be_true }
    end

  end
end
