require 'spec_helper'
module Finitio
  describe SubType, "name" do

    subject{ type.name }

    context 'when provided' do
      let(:type){ SubType.new(intType, {posint: ->(i){}}, "Foo") }

      it 'uses the specified one' do
        subject.should eq("Foo")
      end
    end

    context 'when not provided' do
      let(:type){ SubType.new(intType, posint: ->(i){}) }

      it 'uses the first constraint name' do
        subject.should eq("Posint")
      end
    end

  end
end
