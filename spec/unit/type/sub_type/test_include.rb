require 'spec_helper'
module Qrb
  describe SubType, "include?" do

    let(:type){ SubType.new(intType, {default: ->(i){ i>0 }, small: ->(i){ i<255 }}, "byte") }

    subject{ type.include?(arg) }

    context 'when included on int' do
      let(:arg){ 12 }

      it{ should be_true }
    end

    context 'when not included on int (I)' do
      let(:arg){ -12 }

      it{ should be_false }
    end

    context 'when not included on int (II)' do
      let(:arg){ 255 }

      it{ should be_false }
    end

    context 'when not included' do
      let(:arg){ "12" }

      it{ should be_false }
    end

  end
end
