require 'spec_helper'
module Finitio
  describe Syntax, "metadata" do

    let(:match){
      Syntax.parse(input, root: "metadata")
    }

    describe "value" do
      subject{
        match.value
      }

      context 'simple description' do
        let(:input){ '/- Hello World -/' }

        it{ should eq({description: "Hello World"}) }
      end

      context 'tuple' do
        let(:input){ '/- label: "Hello World" -/' }

        it{ should eq({label: "Hello World"}) }
      end
    end

  end
end
