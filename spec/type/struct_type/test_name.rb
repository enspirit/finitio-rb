require 'spec_helper'
module Finitio
  describe StructType, "name" do

    subject{ type.name }

    context 'when not provided' do
      let(:type){ StructType.new([intType]) }

      it{ should eq("<intType>") }
    end

    context 'when provided' do
      let(:type){ StructType.new([intType], "myStruct") }

      it{ should eq("myStruct") }
    end

  end
end
