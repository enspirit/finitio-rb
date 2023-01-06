require 'spec_helper'
require 'finitio/inference'
module Finitio
  describe Inference do

    let(:system) {
      Finitio.system <<~FIO
        @import finitio/data

        Nil = .NilClass
        Boolean = .TrueClass|.FalseClass
        Integer = .Integer
        Date = .Date <iso8601> .String \\( s | Date.iso8601(s) )
                                       \\( d | d.iso8601       )
        String = .String
      FIO
    }

    let(:input) {
      [
        { "id" => 1, "createdAt" => "2018-01-12", "size" => "15", "priority" => "XL", "meta" => { foo: true, bar: "foo" }, "hobbies" => [] },
        { "id" => 2, "createdAt" => "2019-02-23", "size" => "1",  "priority" => "L",  "meta" => { foo: true, bar: "baz" }, "hobbies" => ["testing"] },
        { "id" => 3, "createdAt" => "2018-07-15", "size" => "7",  "priority" => "S",  "meta" => { foo: true, bar: "bar" } },
        { "id" => 4, "createdAt" => "2019-12-12", "size" => "9",  "priority" => "M",  "meta" => { foo: true, baz: "baz" } },
        { "id" => 4, "createdAt" => nil,          "size" => "9",  "priority" => "M"  },
      ]
    }

    it 'works as expected' do
      result = Inference.new(system).call(input)
      expect(result).to be_a(SeqType)
      expect(result.elm_type).to be_a(MultiTupleType)
      expect(result.elm_type[:id].type.name).to eql("Integer")
      expect(result.elm_type[:createdAt].type.name).to eql("Date|Nil")
      expect(result.elm_type[:size].type.name).to eql("String")
      expect(result.elm_type[:priority].type.name).to eql("String")

      #puts result
    end

  end
end
