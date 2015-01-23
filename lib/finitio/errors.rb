module Finitio

  class Error < StandardError

    def initialize(msg, cause = nil)
      super(msg)
      @cause = cause
    end
    attr_reader :cause

    def root_cause(sandbox = true)
      # 1) no deeper cause, it's me
      return self if cause.nil?

      # 2) not a Finitio cause and sandbox
      return self if sandbox and not cause.is_a?(Error)

      # 3) cause may not go deeper
      return cause unless cause.respond_to?(:root_cause)

      # 4) delegate
      cause.root_cause
    end

  end # class Error

  class TypeError < Error

    def initialize(msg, cause = nil, location = nil)
      super(msg, cause)
      @location = location || ''
    end
    attr_reader :location

  end # class TypeError

end # module Finitio
