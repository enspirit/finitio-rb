require 'spec_helper'

describe "Heading extra are properly resolved" do

  describe "When the extra map to a type" do
    let(:schema){
      Finitio.system <<~F
        Type = { ... : World }
        World = .String
        Type
      F
    }

    it 'works' do
      expect(schema.dress("hello" => "World")).to eql(hello: "World")
    end
  end

  describe "When the extra maps to nothing" do
    let(:schema){
      Finitio.system <<~F
        {
          hello: .String
          ...
        }
      F
    }

    it 'works' do
      expect(schema.dress("hello" => "World")).to eql(hello: "World")
    end

    it 'supports extra' do
      expect(schema.dress({
        "hello" => "World",
        "extra" => "Foo"
      })).to eql(hello: "World")
    end
  end

end