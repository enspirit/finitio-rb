module Qrb
  class UpHandler

    def initialize
      @stack = []
    end

    def branch(type, value)
      push([type, value])
      res = yield
    ensure
      pop
      res
    end

    def just_try
      [ true, yield ]
    rescue UpError => cause
      [ false, nil ]
    end

    def try
      yield
    rescue UpError => cause
      fail!(cause)
    end

    def fail!(*args)
      options = {}
      cause   = nil

      # Parse arguments
      args.each do |arg|
        case arg
        when Hash  then options = arg
        when Error then cause = arg
        end
      end

      # Build the error message
      msg = options[:message] ? options[:message] : default_error_message

      # Raise the error now
      raise UpError.new(msg, cause)
    end

    def default_error_message
      value_s, type_s = value_to_s(top_value), type_to_s(top_type)
      "Invalid value `#{value_s}` for #{type_s}"
    end

  private

    attr_reader :stack

    def push(pair)
      @stack << pair
    end

    def pop
      @stack.pop
    end

    def top_type
      stack.last.first
    end

    def top_value
      stack.last.last
    end

  private

    def value_to_s(value)
      s = value.to_s
      s = "#{s[0..25]}..." if s.size>25
      s
    end

    def type_to_s(type)
      type.name.to_s
    end

  end # class UpHandler
end # module Qrb
