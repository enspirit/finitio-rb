require 'spec_helper'
module Qrb
  describe RealmBuilder, "DSL#adt" do

    let(:builder){ RealmBuilder.new }

    let(:contracts){
      {rgb: [intType, RgbContract], hex: [floatType, HexContract]}
    }

    shared_examples_for "The <Color> type" do

      it{ should be_a(AdType) }

      it 'should have the correct ruby type' do
        subject.ruby_type.should be(Color)
      end

      it 'should have the two contracts' do
        subject.contracts.keys.should eq([:rgb, :hex])
      end
    end

    describe 'the normal version' do

      before do
        subject
        # it should not be saved
        builder.realm[subject.name].should be_nil
      end

      context 'when used with the standard signature' do
        subject{
          builder.adt(Color, contracts)
        }

        it_should_behave_like "The <Color> type"

        it 'should have the correct name' do
          subject.name.should eq("Color")
        end
      end

      context 'when used with a name' do
        subject{
          builder.adt(Color, contracts, "MyColor")
        }

        it_should_behave_like "The <Color> type"

        it 'should have the correct name' do
          subject.name.should eq("MyColor")
        end
      end

    end

    describe 'the ! version' do
      subject{
        builder.adt!(Color, contracts)
      }

      it_should_behave_like "The <Color> type"

      it 'should be saved' do
        subject
        builder.realm['Color'].should be(subject)
      end
    end

  end
end
