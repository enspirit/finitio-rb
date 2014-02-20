require 'spec_helper'
module Qrb
  describe UnionType, "initialize" do

    context 'with valid candidates' do
      let(:union){ UnionType.new("myType", [intType, floatType]) }

      it 'sets the variable instances' do
        union.name.should eq("myType")
        union.candidates.should eq([intType, floatType])
      end
    end

    context 'with invalid candidates' do
      let(:union){ UnionType.new("foo", ["bar"]) }

      it 'should raise an error' do
        ->{
          union
        }.should raise_error(ArgumentError, %Q{[Qrb::Type] expected, got ["bar"]})
      end
    end

  end
end
