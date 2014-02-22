require 'spec_helper'
module Qrb
  describe SetType, 'name' do

    subject{ type.name }

    context 'when not specified' do
      let(:type){
        SetType.new(intType)
      }

      it{ should eq('{intType}') }
    end

    context 'when specified' do
      let(:type){
        SetType.new(intType, "foo")
      }

      it{ should eq('foo') }
    end

  end
end
