require 'spec_helper'
module Finitio
  describe TypeFactory, "DSL#adt" do

    let(:factory){ TypeFactory.new }

    let(:contracts){
      { rgb: [intType,   Color.method(:rgb), Finitio::IDENTITY ],
        hex: [floatType, Color.method(:hex), Finitio::IDENTITY ]}
    }

    shared_examples_for "The <Color> type" do

      it{ should be_a(AdType) }

      it 'should have the correct ruby type' do
        expect(subject.ruby_type).to be(Color)
      end

      it 'should have the two contracts' do
        expect(subject.contracts.map(&:name)).to eq([:rgb, :hex])
      end
    end

    before do
      subject
    end

    context 'when used with the standard signature' do
      subject{
        factory.adt(Color, contracts)
      }

      it_should_behave_like "The <Color> type"

      it 'should have the correct name' do
        expect(subject.name).to eq("Color")
      end
    end

    context 'when used with a name' do
      subject{
        factory.adt(Color, contracts, "MyColor")
      }

      it_should_behave_like "The <Color> type"

      it 'should have the correct name' do
        expect(subject.name).to eq("MyColor")
      end
    end

  end
end
