# Nil
NilClass = .NilClass
Nil      = .NilClass

# Booleans
True    = .TrueClass
False   = .FalseClass
Boolean = .TrueClass|.FalseClass

# Numbers
Numeric = .Numeric
Fixnum  = .Fixnum
Bignum  = .Bignum
Integer = .Integer
Float   = .Float
Real    = .Float

# Date
Date    = .Date <iso8601> .String \( s | Date.iso8601(s) )
                                  \( d | d.iso8601       )
