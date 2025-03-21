module Finitio
  module Typescript

    BUILTIN_MAPPING = {
      NilClass => "null",
      String => "string",
      Integer => "number",
      Fixnum => "number",
      Bignum => "number",
      Float => "number",
      Numeric => "number",
      TrueClass => "boolean",
      FalseClass => "boolean",
      Object => "any",
      DateTime => "Date",
      Date => "Date"
    }

  end
  class BuiltinType

    def to_typescript(*args, &bl)
      mapped = Typescript::BUILTIN_MAPPING[ruby_type]
      if mapped
        mapped
      else
        raise Typescript::Error, "Unable to map #{ruby_type} to json-schema"
      end
    end

  end # class BuiltinType
end # module Finitio
