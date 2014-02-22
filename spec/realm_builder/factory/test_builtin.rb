require 'spec_helper'
module Qrb
  describe RealmBuilder, "Factory#builtin" do

    let(:builder){ RealmBuilder.new }

    context 'when use with a ruby class' do
      subject{ builder.type(Integer) }

      it{ should eq(intType) }
    end

    context 'when use with a ruby class and a name' do
      subject{ builder.type(Integer, "Int") }

      it{ should eq(intType) }

      it 'should have the correct name' do
        subject.name.should eq("Int")
      end
    end

  end
end
