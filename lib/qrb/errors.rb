module Qrb

  class Error < StandardError

    def initialize(msg, cause = nil)
      super(msg)
      @cause = cause
    end
    attr_reader :cause

  end # class Error

  class UpError < Error; end

end # module Qrb
