require 'spec_helper'

describe "The types of generics definitions" do
  describe "When the extra map to a type" do
    let(:schema){
      Finitio.system <<~F
        Collection<T> = [T]

        String = .String
        Collection<String>
      F
    }

    it 'works' do
      expect(schema['Main'].target.name).to eql("Collection<String>")
    end
  end
end
