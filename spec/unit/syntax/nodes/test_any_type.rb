require 'spec_helper'
module Qrb
  describe Syntax, "any_type" do

    subject{
      Syntax.parse(source, root: "any_type")
    }

    let(:compiled){
      subject.compile(type_factory)
    }

    let(:source){ "." }

    it 'compiles to an AnyType' do
      compiled.should be_a(AnyType)
    end

  end
end
