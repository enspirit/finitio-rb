require 'spec_helper'
module Qrb
  describe UserType, "name" do

    subject{ type.name }

    context 'when provided' do
      let(:type){ UserType.new({}, "Foo") }

      it{ should eq('Foo') }
    end

    context 'when not provided' do
      let(:type){ UserType.new({}) }

      it{ should eq('Unnamed') }
    end

  end
end
