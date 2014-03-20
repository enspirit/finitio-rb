module Finitio

  class Error < StandardError

    def initialize(msg, cause = nil)
      super(msg)
      @cause = cause
    end
    attr_reader :cause

  end # class Error

  class TypeError < Error

    def initialize(msg, cause = nil, location = nil)
      super(msg, cause)
      @location = location || ''
    end
    attr_reader :location

  end # class TypeError

end # module Finitio
