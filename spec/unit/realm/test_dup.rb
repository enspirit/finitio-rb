require 'rspec'
module Qrb
  describe Realm, "dup" do

    let(:realm){ Realm.new }

    before do
      realm.add_type(intType)
    end

    subject{ realm.dup }

    it{ should be_a(Realm) }

    it 'should not be the same object' do
      subject.should_not be(realm)
    end

    it 'should have intType' do
      subject['intType'].should eq(intType)
    end

    it 'should not share internals with the original' do
      subject.add_type(floatType)
      subject['floatType'].should_not be_nil
      realm['floatType'].should be_nil
    end

  end
end
