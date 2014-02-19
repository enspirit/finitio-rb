require 'spec_helper'
module Qrb
  describe TupleType, "initialize" do

    let(:heading){
      Heading.new([Attribute.new(:a, intType)])
    }

    subject{ TupleType.new("tupleType", heading) }

    it{ should be_a(TupleType) }

    it 'correctly sets the instance variable' do
      subject.heading.should eq(heading)
    end

  end
end