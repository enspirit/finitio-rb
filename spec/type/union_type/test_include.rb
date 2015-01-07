require 'spec_helper'
module Finitio
  describe UnionType, "include?" do

    let(:type){ UnionType.new([intType, floatType]) }

    subject{ type.include?(arg) }

    context 'when not included' do
      let(:arg){ "12" }

      it{ should eq(false) }
    end

    context 'when included on int' do
      let(:arg){ 12 }

      it{ should eq(true) }
    end

    context 'when included on float' do
      let(:arg){ 12.0 }

      it{ should eq(true) }
    end

  end
end
