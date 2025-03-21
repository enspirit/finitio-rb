module Finitio
  class Type

    TS_TYPE_UNALLOWED_CHARS = /[^<>a-zA-Z_$]/.freeze

    def ts_name
      @name.gsub(TS_TYPE_UNALLOWED_CHARS, '') if @name
    end

  end # class Type
end # module Finitio
