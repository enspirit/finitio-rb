require 'spec_helper'
module Qrb
  describe Attribute, "initialize" do

    subject{ Attribute.new(:red, intType) }

    it 'should correctly set the instance variables' do
      subject.name.should eq(:red)
      subject.type.should eq(intType)
    end

  end
end
