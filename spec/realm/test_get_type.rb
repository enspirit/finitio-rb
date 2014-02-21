require 'rspec'
module Qrb
  describe Realm, "[]" do

    let(:realm){ Realm.new }

    before do
      realm.add_type(intType)
    end

    subject{ realm[name] }

    context 'with an existing type name' do
      let(:name){ "intType" }

      it 'should return the type' do
        subject.should eq(intType)
      end
    end

    context 'with a non existing type name' do
      let(:name){ "noSuchOne" }

      it 'should return nil' do
        subject.should be_nil
      end
    end

  end
end
