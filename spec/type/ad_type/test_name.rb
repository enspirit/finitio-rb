require 'spec_helper'
module Finitio
  describe AdType, "name" do

    subject{ type.name }

    context 'when provided' do
      let(:type){ AdType.new(Color, [], "Foo") }

      it{ should eq('Foo') }
    end

    context 'when not provided' do
      let(:type){ AdType.new(Color, []) }

      it{ should eq('Color') }
    end

  end
end
