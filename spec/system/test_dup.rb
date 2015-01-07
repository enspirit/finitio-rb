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
      expect(subject).not_to be(system)
    end

    it 'should have intType' do
      expect(subject['intType']).to eq(intType)
    end

    it 'should not share internals with the original' do
      subject.add_type(floatType)
      expect(subject['floatType']).not_to be_nil
      expect(system['floatType']).to be_nil
    end

  end
end
