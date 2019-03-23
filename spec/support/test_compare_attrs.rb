require 'spec_helper'
module Finitio
  describe Support, "compare_attrs" do
    include Support

    context 'with arrays' do
      it 'works on same attrs' do
        h1 = [:a, :b]
        h2 = [:b, :a]
        shared, mine, yours = compare_attrs(h1, h2)
        expect(shared).to eql([:a, :b])
        expect(mine).to eql([])
        expect(yours).to eql([])
      end

      it 'works on not same attrs' do
        h1 = [ :a, :b ]
        h2 = [ :c, :a ]
        shared, mine, yours = compare_attrs(h1, h2)
        expect(shared).to eql([:a])
        expect(mine).to eql([:b])
        expect(yours).to eql([:c])
      end
    end

    context 'with hashes' do
      it 'works on same attrs' do
        h1 = { a: 1, b: 2 }
        h2 = { a: 1, b: 2 }
        shared, mine, yours = compare_attrs(h1, h2)
        expect(shared).to eql([:a, :b])
        expect(mine).to eql([])
        expect(yours).to eql([])
      end

      it 'works on not same attrs' do
        h1 = { a: 1, b: 2 }
        h2 = { a: 1, c: 2 }
        shared, mine, yours = compare_attrs(h1, h2)
        expect(shared).to eql([:a])
        expect(mine).to eql([:b])
        expect(yours).to eql([:c])
      end
    end

    context 'with a block' do
      it 'works on same attrs' do
        h1 = [{:name => :a}, {:name => :b}]
        h2 = [{:name => :b}, {:name => :a}]
        shared, mine, yours = compare_attrs(h1, h2){|a| a[:name] }
        expect(shared).to eql([:a, :b])
        expect(mine).to eql([])
        expect(yours).to eql([])
      end

      it 'works on not same attrs' do
        h1 = [{:name => :a}, {:name => :b}]
        h2 = [{:name => :c}, {:name => :a}]
        shared, mine, yours = compare_attrs(h1, h2){|a| a[:name] }
        expect(shared).to eql([:a])
        expect(mine).to eql([:b])
        expect(yours).to eql([:c])
      end
    end

  end
end
