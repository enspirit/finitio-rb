require 'set'
module Qrb
  class UnionType < Type

    def initialize(name, candidates)
      unless candidates.all?{|c| c.is_a?(Type) }
        raise ArgumentError, "[Qrb::Type] expected, got #{candidates}"
      end

      super(name)
      @candidates = candidates.freeze
    end
    attr_reader :candidates

    def up(value, handler = UpHandler.new)
      # Try each candidate in turn. Do nothing on UpError as
      # the next candidate could be the good one! Return the
      # first successfully uped.
      candidates.each do |c|
        success, uped = handler.just_try do
          c.up(value, handler)
        end
        return uped if success
      end

      # No one succeed, just fail
      handler.failed!(self, value)
    end

    def ==(other)
      return false unless other.is_a?(UnionType)
      set_equal?(candidates, other.candidates)
    end
    alias :eql? :==

    def hash
      self.class.hash ^ set_hash(self.candidates)
    end

  end # class UnionType
end # module Qrb
