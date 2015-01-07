require 'spec_helper'
module Finitio
  describe RelationType, "include?" do

    let(:heading){
      Heading.new([Attribute.new(:a, intType)])
    }

    let(:type){ RelationType.new(heading) }

    subject{ type.include?(arg) }

    context 'when a empty set' do
      let(:arg){ Set.new }

      it{ should eq(true) }
    end

    context 'when a valid, non empty set' do
      let(:arg){ Set.new }

      before do
        arg << {a: 12} << {a: 15}
      end

      it{ should eq(true) }
    end

    context 'when not a set' do
      let(:arg){ "foo" }

      it{ should eq(false) }
    end

    context 'when a set containing invalid tuples' do
      let(:arg){ Set.new }

      before do
        arg << {a: 12.0}
      end

      it{ should eq(false) }
    end

  end
end
