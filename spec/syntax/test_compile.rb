require 'spec_helper'
module Finitio
  describe Syntax, '.compile' do

    subject do
      Syntax.compile(source)
    end

    context 'with a single main type' do
      let(:source){
        <<-EOF.strip
        .Integer
        EOF
      }

      it{ should be_a(System) }

      it 'should have main type' do
        subject.main.should be_a(BuiltinType)
        subject['Main'].should be(subject.main)
      end
    end

    context 'with a single main alias type' do
      let(:source){
        <<-EOF.strip
        Int = .Integer
        Int
        EOF
      }

      it{ should be_a(System) }

      it 'should have main type' do
        subject.main.should be_a(AliasType)
        subject['Main'].should be(subject.main)
      end
    end

  end
end
