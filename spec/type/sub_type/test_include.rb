require 'spec_helper'
module Finitio
  describe SubType, "include?" do

    let(:type){ SubType.new(intType, [byte_min, byte_max], "byte") }

    subject{ type.include?(arg) }

    context 'when included on int' do
      let(:arg){ 12 }

      it{ should eq(true) }
    end

    context 'when not included on int (I)' do
      let(:arg){ -12 }

      it{ should eq(false) }
    end

    context 'when not included on int (II)' do
      let(:arg){ 256 }

      it{ should eq(false) }
    end

    context 'when not included' do
      let(:arg){ "12" }

      it{ should eq(false) }
    end

  end
end
