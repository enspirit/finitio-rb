require 'spec_helper'
module Finitio
  describe Attribute, "initialize" do

    context 'when implicitely required' do
      subject{ Attribute.new(:red, intType) }

      it 'should correctly set the instance variables' do
        subject.name.should eq(:red)
        subject.type.should eq(intType)
        subject.should be_required
      end
    end

    context 'when not required' do
      subject{ Attribute.new(:red, intType, false) }

      it 'should correctly set the instance variables' do
        subject.name.should eq(:red)
        subject.type.should eq(intType)
        subject.should_not be_required
      end
    end

  end
end
