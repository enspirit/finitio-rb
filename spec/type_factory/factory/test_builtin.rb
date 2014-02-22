require 'spec_helper'
module Qrb
  describe TypeFactory, "Factory#builtin" do

    let(:factory){ TypeFactory.new }

    context 'when use with a ruby class' do
      subject{ factory.type(Integer) }

      it{ should eq(intType) }
    end

    context 'when use with a ruby class and a name' do
      subject{ factory.type(Integer, "Int") }

      it{ should eq(intType) }

      it 'should have the correct name' do
        subject.name.should eq("Int")
      end
    end

  end
end
