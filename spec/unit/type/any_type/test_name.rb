require 'spec_helper'
module Qrb
  describe AnyType, "name" do

    subject{ type.name }

    context 'when not provided' do
      let(:type){ AnyType.new }

      it 'uses the default name' do
        subject.should eq("Any")
      end
    end

    context 'when provided' do
      let(:type){ AnyType.new("foo") }

      it 'uses the specified name' do
        subject.should eq("foo")
      end
    end

  end
end
