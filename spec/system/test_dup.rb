require 'rspec'
module Finitio
  describe System, "dup" do

    let(:system){ System.new }

    before do
      system.add_type(intType)
    end

    subject{ system.dup }

    it{ should be_a(System) }

    it 'should not be the same object' do
      subject.should_not be(system)
    end

    it 'should have intType' do
      subject['intType'].should eq(intType)
    end

    it 'should not share internals with the original' do
      subject.add_type(floatType)
      subject['floatType'].should_not be_nil
      system['floatType'].should be_nil
    end

  end
end
