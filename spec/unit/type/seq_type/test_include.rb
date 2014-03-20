require 'spec_helper'
module Finitio
  describe SeqType, "include?" do

    let(:type){ SeqType.new(intType) }

    subject{ type.include?(arg) }

    context 'when included on empty array' do
      let(:arg){ [] }

      it{ should be_true }
    end

    context 'when included on non empty array' do
      let(:arg){ [] }

      before do
        arg << 12
      end

      it{ should be_true }
    end

    context 'when not an array' do
      let(:arg){ Set.new }

      it{ should be_false }
    end

    context 'when an array with non ints' do
      let(:arg){ [] }

      before do
        arg << 12
        arg << "foo"
      end

      it{ should be_false }
    end

  end
end
