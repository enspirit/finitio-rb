require 'spec_helper'
module Finitio
  module Syntax
    describe Expr, "to_proc_source" do

      def source(src)
        Syntax.parse(src, { root: :expr, memoize: true }).to_proc_source
      end

      context "on literals" do

        it 'returns an empty array' do
          expect(source("true")).to eq("true")
        end
      end

      context "on a single identifier" do

        it 'works' do
          expect(source("foo")).to eq("foo")
        end
      end
        
      context "on a comparison" do

        it 'works' do
          expect(source("foo == bar")).to eq(%Q{foo.==(bar)})
        end
      end

      context "on a OO call" do

        it 'works' do
          expect(source("foo.bar")).to eq(%Q{foo.fetch(:bar)})
        end

        it 'works' do
          expect(source("foo.bar.baz")).to eq(%Q{foo.fetch(:bar).fetch(:baz)})
        end
      end
    end
  end
end
