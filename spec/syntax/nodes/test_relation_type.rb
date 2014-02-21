require 'spec_helper'
module Qrb
  describe Syntax, "relation_type" do

    subject{
      Syntax.parse(input, root: "relation_type")
    }

    let(:compiled){
      subject.compile(realm_builder)
    }

    context 'empty heading' do
      let(:input){ '{{ }}' }

      it 'compiles to a RelationType' do
        compiled.should be_a(RelationType)
        compiled.heading.should be_empty
      end
    end

    context '{{a: .Integer}}' do
      let(:input){ '{{a: .Integer}}' }

      it 'compiles to a RelationType' do
        compiled.should be_a(RelationType)
        compiled.heading.size.should eq(1)
      end
    end

    context '{{a: .Integer, b: .Float}}' do
      let(:input){ '{{a: .Integer, b: .Float}}' }

      it 'compiles to a RelationType' do
        compiled.should be_a(RelationType)
        compiled.heading.size.should eq(2)
      end
    end

  end
end
