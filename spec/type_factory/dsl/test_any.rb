require 'spec_helper'
module Finitio
  describe TypeFactory, "DSL#any" do

    let(:factory){ TypeFactory.new }

    context 'without a name' do
      subject do
        factory.any
      end

      it{ should be_a(AnyType) }
    end

    context 'with a name' do
      subject do
        factory.any("foo")
      end

      it{ should be_a(AnyType) }

      it 'should have the name' do
        subject.name.should eq('foo')
      end
    end

  end
end
