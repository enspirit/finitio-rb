require 'rspec'
module Finitio
  describe System, "add_type" do

    let(:system){ System.new }

    subject{ system.add_type(type) }

    context 'with a valid type' do
      let(:type){ intType }

      it 'should return the created type' do
        subject.should be(type)
      end

      it 'should add the type' do
        subject
        system[type.name].should be(type)
      end
    end

    context 'with an invalid type' do
      let(:type){ "foo" }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(ArgumentError, "Finitio::Type expected, got `foo`")
      end
    end

    context 'with a duplicate type name' do
      let(:type){ intType }

      before do
        system.add_type(type)
      end

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(Finitio::Error, "Duplicate type name `intType`")
      end
    end

  end
end
