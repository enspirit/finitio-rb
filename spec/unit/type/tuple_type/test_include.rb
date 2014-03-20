require 'spec_helper'
module Finitio
  describe TupleType, "include?" do

    let(:heading){
      Heading.new([Attribute.new(:a, intType)])
    }

    let(:type){ TupleType.new(heading) }

    subject{ type.include?(arg) }

    context 'when a valid hash' do
      let(:arg){ {a: 12} }

      it{ should be_true }
    end

    context 'when an invalid hash (too many attributes)' do
      let(:arg){ {a: 12, b: 15} }

      it{ should be_false }
    end

    context 'when an invalid hash (too few attributes)' do
      let(:arg){ {b: 12} }

      it{ should be_false }
    end

    context 'when an invalid hash (wrong type)' do
      let(:arg){ {a: 12.0} }

      it{ should be_false }
    end

  end
end
