require 'set'
module Qrb
  class UnionType < Type

    def initialize(name, candidates)
      unless candidates.all?{|c| c.is_a?(Type) }
        raise "Qrb::Type expected, got #{candidates}"
      end

      super(name)
      @candidates = candidates.freeze
    end
    attr_reader :candidates

    def up(value)
      # return the first possible success
      candidates.each do |c|
        begin
          return c.up(value)
        rescue UpError
        end
      end

      # no one, fail
      up_error!(value)
    end

    def ==(other)
      return nil unless other.is_a?(UnionType) 
      set_equal?(candidates, other.candidates)
    end
    alias :eql? :==

    def hash
      set_hash(self.candidates)
    end

  end # class UnionType
end # module Qrb
