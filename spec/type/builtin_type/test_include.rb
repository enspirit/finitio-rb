require 'spec_helper'
module Finitio
  describe BuiltinType, "include?" do

    let(:type){ BuiltinType.new(Integer) }

    subject{ type.include?(arg) }

    context 'when not included' do
      let(:arg){ "12" }

      it{ should eq(false) }
    end

    context 'when included' do
      let(:arg){ 12 }

      it{ should eq(true) }
    end

  end
end
