require 'spec_helper'
module Finitio
  describe MultiRelationType, "include?" do

    let(:heading){
      Heading.new([
        Attribute.new(:a, intType),
        Attribute.new(:b, intType, false)
      ])
    }

    let(:type){ MultiRelationType.new(heading) }

    subject{ type.include?(arg) }

    context 'when a empty set' do
      let(:arg){ Set.new }

      it{ should eq(true) }
    end

    context 'when a valid, non empty set' do
      let(:arg){ Set.new }

      before do
        arg << {a: 12, b: 15} << {a: 15, b: 16}
      end

      it{ should eq(true) }
    end

    context 'when a valid, non empty set but missing optionals' do
      let(:arg){ Set.new }

      before do
        arg << {a: 12} << {a: 15, b: 16}
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

    context 'when a set containing tuples with missing required' do
      let(:arg){ Set.new }

      before do
        arg << {b: 12}
      end

      it{ should eq(false) }
    end

    context 'when a set containing tuples with extra' do
      let(:arg){ Set.new }

      before do
        arg << {a: 12, b: 12, c: 15}
      end

      it{ should eq(false) }
    end

    context 'when a set containing tuples with invalid optional' do
      let(:arg){ Set.new }

      before do
        arg << {a: 12, b: 12.5}
      end

      it{ should eq(false) }
    end

  end
end
