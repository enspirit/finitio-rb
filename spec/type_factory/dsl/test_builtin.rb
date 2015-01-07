require 'spec_helper'
module Finitio
  describe TypeFactory, "DSL#builtin" do

    let(:factory){ TypeFactory.new }

    shared_examples_for "The Integer builtin type" do

      it{ should be_a(BuiltinType) }

      it 'should have the correct ruby type' do
        expect(subject.ruby_type).to be(Integer)
      end
    end

    before do
      subject
    end

    context 'when used with a ruby class and no name' do
      subject{
        factory.builtin(Integer)
      }

      it_should_behave_like "The Integer builtin type"

      it 'should have the correct name' do
        expect(subject.name).to eq("Integer")
      end
    end

    context 'when used with a ruby class and a name' do
      subject{
        factory.builtin(Integer, "Int")
      }

      it_should_behave_like "The Integer builtin type"

      it 'should have the correct name' do
        expect(subject.name).to eq("Int")
      end
    end

  end
end
