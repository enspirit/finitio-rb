require 'spec_helper'
module Finitio
  describe Syntax, "constraints" do

    subject{
      Syntax.parse(input, root: "constraints")
    }

    let(:compiled){
      subject.compile("a")
    }

    let(:ast){
      subject.to_ast('a')
    }

    context 'a >= 10' do
      let(:input){ 'a >= 10' }

      it 'compiles to an Array' do
        compiled.should be_a(Array)
        compiled.size.should eq(1)
        compiled.first.should be_a(Constraint)
      end

      it 'has the expected AST' do
        ast.should eq([[
          :constraint,
          "default",
          [:fn, [:parameters, "a"], [:source, "a >= 10"]]
        ]])
      end
    end

    context 'foo: a >= 10' do
      let(:input){ 'foo: a >= 10' }

      it 'compiles to an Array' do
        compiled.should be_a(Array)
        compiled.size.should eq(1)
        compiled.first.should be_a(Constraint)
        compiled.map(&:name).should eq([:foo])
      end

      it 'has the expected AST' do
        ast.should eq([[
          :constraint,
          "foo",
          [:fn, [:parameters, "a"], [:source, "a >= 10"]]
        ]])
      end
    end

    context 'foo: a >= 10, bar: a <= 255' do
      let(:input){ 'foo: a >= 10, bar: a <= 255' }

      it 'compiles to an Array' do
        compiled.should be_a(Array)
        compiled.size.should eq(2)
        compiled.first.should be_a(Constraint)
        compiled.map(&:name).should eq([:foo, :bar])
      end

      it 'has the expected AST' do
        ast.should eq([
          [
            :constraint,
            "foo",
            [:fn, [:parameters, "a"], [:source, "a >= 10"]]
          ],
          [
            :constraint,
            "bar",
            [:fn, [:parameters, "a"], [:source, "a <= 255"]]
          ]
        ])
      end
    end

    context 'foo: a >= 10, foo: a <= 255' do
      let(:input){ 'foo: a >= 10, foo: a <= 255' }

      it 'raises an error' do
        ->{
          compiled
        }.should raise_error("Duplicate constraint name `foo`")
      end
    end

  end
end
