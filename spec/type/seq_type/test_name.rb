require 'spec_helper'
module Qrb
  describe SeqType, 'name' do

    subject{ type.name }

    context 'when not specified' do
      let(:type){
        SeqType.new(intType)
      }

      it{ should eq('[intType]') }
    end

    context 'when specified' do
      let(:type){
        SeqType.new(intType, "foo")
      }

      it{ should eq('foo') }
    end

  end
end
