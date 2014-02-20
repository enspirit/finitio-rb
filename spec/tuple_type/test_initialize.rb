require 'spec_helper'
module Qrb
  describe TupleType, "initialize" do

    let(:heading){
      Heading.new([Attribute.new(:a, intType)])
    }

    context 'with a valid heading' do
      subject{ TupleType.new("tupleType", heading) }

      it{ should be_a(TupleType) }

      it 'correctly sets the instance variable' do
        subject.heading.should eq(heading)
      end
    end

    context 'with an invalid heading' do
      subject{ TupleType.new("foo", "bar") }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(ArgumentError, "Heading expected, got `bar`")
      end
    end

  end
end