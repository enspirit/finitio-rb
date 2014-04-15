require 'spec_helper'
module Finitio
  describe StructType, "initialize" do

    context 'with valid components' do
      subject{ StructType.new([intType]) }

      it{ should be_a(StructType) }
    end

    context 'with invalid components' do
      subject{ StructType.new("foo") }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(ArgumentError, "[Finitio::Type] expected, got `foo`")
      end
    end

  end
end
