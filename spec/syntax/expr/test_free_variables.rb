require 'spec_helper'
module Finitio
  module Syntax
    describe Expr, "free_variables" do

      def fv(src)
        Syntax.parse(src, { root: :expr, memoize: true }).free_variables
      end

      context "on literals" do

        it 'returns an empty array' do
          expect(fv("true")).to eq([])
        end
      end

      context "on a single identifier" do

        it 'works' do
          expect(fv("foo")).to eq(["foo"])
        end
      end
        
      context "on a comparison" do

        it 'works' do
          expect(fv("foo == bar")).to eq(["foo", "bar"])
        end
      end

      context "on a function call" do

        it 'works' do
          expect(fv("foo(bar)")).to eq(["bar"])
        end
      end

      context "on a OO call" do

        it 'works' do
          expect(fv("foo.bar")).to eq(["foo"])
        end
      end
    end
  end
end
