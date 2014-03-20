require 'spec_helper'
module Finitio
  describe UnionType, "name" do

    subject{ type.name }

    context 'when not provided' do
      let(:type){ UnionType.new([intType, floatType]) }

      it{ should eq('intType|floatType') }
    end

    context 'when provided' do
      let(:type){ UnionType.new([intType, floatType], "union") }

      it{ should eq('union') }
    end

  end
end
