require 'spec_helper'
module Qrb
  describe SetType, "include?" do

    let(:type){ SetType.new(intType) }

    subject{ type.include?(arg) }

    context 'when included on empty set' do
      let(:arg){ Set.new }

      it{ should be_true }
    end

    context 'when included on non empty set' do
      let(:arg){ Set.new }

      before do
        arg << 12
      end

      it{ should be_true }
    end

    context 'when not a set' do
      let(:arg){ [] }

      it{ should be_false }
    end

    context 'when a set with non ints' do
      let(:arg){ Set.new }

      before do
        arg << 12
        arg << "foo"
      end

      it{ should be_false }
    end

  end
end
