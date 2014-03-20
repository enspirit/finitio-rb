module Finitio
  class DressHelper

    def initialize
      @stack = []
    end

    def iterate(value)
      value.each.each_with_index do |elm, index|
        deeper(index) do
          yield(elm, index)
        end
      end
    end

    def deeper(location)
      @stack.push(location.to_s)
      res = yield
    ensure
      @stack.pop
      res
    end

    def just_try(rescue_on = TypeError)
      [ true, yield ]
    rescue rescue_on => cause
      [ false, nil ]
    end

    def try(type, value)
      yield
    rescue TypeError => cause
      failed!(type, value, cause)
    end

    def failed!(type, value, cause = nil)
      msg = default_error_message(type, value)
      raise TypeError.new(msg, cause, location)
    end

    def fail!(msg, cause = nil)
      raise TypeError.new(msg, cause, location)
    end

    def default_error_message(type, value)
      value_s, type_s = value_to_s(value), type_to_s(type)
      "Invalid value `#{value_s}` for #{type_s}"
    end

    def location
      @stack.join('/')
    end

  private

    def value_to_s(value)
      return 'null' if value.nil?
      s = value.to_s
      s = "#{s[0..25]}..." if s.size>25
      s
    end

    def type_to_s(type)
      type.name.to_s
    end

  end # class DressHelper
end # module Finitio
