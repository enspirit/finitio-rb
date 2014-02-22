require 'spec_helper'
module Qrb
  describe Syntax, "ad_type" do

    subject{
      Syntax.parse(input, root: "ad_type")
    }

    let(:compiled){
      subject.compile(type_factory)
    }

    context 'One contract' do
      let(:input){ '.Color <rgb> {r: .Integer, g: .Integer, b: .Integer}' }

      it 'compiles to an AdType' do
        compiled.should be_a(AdType)
        compiled.ruby_type.should be(Color)
        compiled.contract_names.should eq([:rgb])
      end

      it 'should behave as expected' do
        compiled.from_q(r: 138, g: 43, b: 226).should eq(blueviolet)
      end
    end

    context 'Two contracts' do
      let(:input){
        <<-TYPE.strip
        .Color <rgb> {r: .Integer, g: .Integer, b: .Integer},
               <hex> .String
        TYPE
      }

      it 'compiles to an AdType' do
        compiled.should be_a(AdType)
        compiled.ruby_type.should be(Color)
        compiled.contract_names.should eq([:rgb, :hex])
      end

      it 'should behave as expected' do
        compiled.from_q("#8A2BE2").should eq(blueviolet)
      end
    end

    context 'No ruby class' do
      let(:input){ '<as> {r: .Integer}' }

      it 'compiles to an AdType' do
        compiled.should be_a(AdType)
        compiled.ruby_type.should be(Object)
        compiled.contract_names.should eq([:as])
      end

      it 'should behave as expected' do
        compiled.from_q(r: 12).should eq(r: 12)
      end
    end

    context 'Duplicate contract name' do
      let(:input){ '.Color <rgb> {r: .Integer}, <rgb> .String' }

      it 'raises an error' do
        ->{
          compiled
        }.should raise_error(Error, "Duplicate contract name `rgb`")
      end
    end

  end
end
