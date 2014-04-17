require 'spec_helper'
module Finitio
  describe Syntax, "sub_type" do

    subject{
      Syntax.parse(input, root: "sub_type")
    }

    let(:compiled){
      subject.compile(type_factory)
    }

    let(:ast){
      subject.to_ast
    }

    context '.Integer( i | i >= 0 )' do
      let(:input){ '.Integer( i | i >= 0 )' }

      it 'compiles to a SubType' do
        compiled.should be_a(SubType)
        compiled.super_type.should be_a(BuiltinType)
        compiled.super_type.ruby_type.should be(Integer)
      end

      it 'has the expected AST' do
        ast.should eq([
          :sub_type,
          [:builtin_type, "Integer"],
          [:constraint, "default", [:fn, [:parameters, "i"], [:source, "i >= 0"]]]
        ])
      end
    end

    context '.Integer( i | positive: i >= 0 )' do
      let(:input){ '.Integer( i | positive: i >= 0 )' }

      it 'compiles to a SubType' do
        compiled.should be_a(SubType)
        compiled.super_type.should be_a(BuiltinType)
        compiled.super_type.ruby_type.should be(Integer)
      end

      it 'has the correct constraints' do
        compiled.constraints.map(&:name).should eq([:positive])
      end

      it 'has the expected AST' do
        ast.should eq([
          :sub_type,
          [:builtin_type, "Integer"],
          [:constraint, "positive", [:fn, [:parameters, "i"], [:source, "i >= 0"]]]
        ])
      end
    end

    context '.Integer( i | positive: i >= 0, ... )' do
      let(:input){ '.Integer( i | positive: i >= 0, small: i <= 255 )' }

      it 'compiles to a SubType' do
        compiled.should be_a(SubType)
        compiled.super_type.should be_a(BuiltinType)
        compiled.super_type.ruby_type.should be(Integer)
      end

      it 'has the correct constraints' do
        compiled.constraints.map(&:name).should eq([:positive, :small])
      end

      it 'has the expected AST' do
        ast.should eq([
          :sub_type,
          [:builtin_type, "Integer"],
          [:constraint, "positive", [:fn, [:parameters, "i"], [:source, "i >= 0"]]],
          [:constraint, "small",    [:fn, [:parameters, "i"], [:source, "i <= 255"]]]
        ])
      end
    end

  end
end
