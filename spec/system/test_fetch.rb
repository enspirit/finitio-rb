require 'rspec'
module Finitio
  describe System, "fetch" do

    let(:system){ System.new }

    before do
      system.add_type(intType)
    end

    subject{ system.fetch(name) }

    context 'with an existing type name' do
      let(:name){ "intType" }

      it 'should return the type' do
        expect(subject).to eq(intType)
      end
    end

    context 'with a non existing type name and no block' do
      let(:name){ "noSuchOne" }

      it 'should raise an error' do
        expect{
          subject
        }.to raise_error(KeyError, /noSuchOne/)
      end
    end

    context 'with a non existing type name and a block' do
      subject{
        system.fetch("noSuchOne"){ "bar" }
      }

      it 'should yield the block' do
        expect(subject).to eq("bar")
      end
    end

    context 'with an imported type' do
      subject{
        s = System.new
        s.add_import(system)
        s.fetch("intType", imports, &fallback)
      }

      context "specifying the use of imports" do
        let(:imports) { true }
        let(:fallback){ ->(name){ raise } }

        it 'should return the type' do
          expect(subject).to eq(intType)
        end
      end

      context "specifying not to use the imports" do
        let(:imports) { false }
        let(:fallback){ ->(name){ "bar" } }

        it 'should yield the fallback block' do
          expect(subject).to eq("bar")
        end
      end

      context "specifying not to use the imports and no fallbak" do
        let(:imports) { false }
        let(:fallback){ nil }

        it 'should yield the fallback block' do
          expect {
            subject
          }.to raise_error
        end
      end
    end

  end
end
