require 'rspec'
module Finitio
  describe System, "add_type" do

    let(:system){ System.new }

    subject{ system.add_type(type) }

    context 'with a valid type' do
      let(:type){ intType }

      it 'should return the created type' do
        expect(subject).to be(type)
      end

      it 'should add the type' do
        subject
        expect(system[type.name]).to be(type)
      end
    end

    context 'with an invalid type' do
      let(:type){ "foo" }

      it 'should raise an error' do
        expect{
          subject
        }.to raise_error(ArgumentError, "Unable to factor a Finitio::Type from `foo`")
      end
    end

    context 'with a duplicate type name' do
      let(:type){ intType }

      before do
        system.add_type(type)
      end

      it 'should raise an error' do
        expect{
          subject
        }.to raise_error(Finitio::Error, "Duplicate type name `intType`")
      end
    end

  end
end
