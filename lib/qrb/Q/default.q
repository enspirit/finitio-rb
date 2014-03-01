# Nil
NilClass = .NilClass
Nil      = .NilClass

# Booleans
TrueClass  = .TrueClass
FalseClass = .TrueClass
True       = .TrueClass
False      = .FalseClass
Boolean    = .TrueClass|.FalseClass

# Numbers
Numeric = .Numeric
Fixnum  = .Fixnum
Bignum  = .Bignum
Integer = .Integer
Float   = .Float
Real    = .Float

# String
String  = .String

# Date, Time, DateTime
Date     = .Date     <iso8601> .String \( s | Date.iso8601(s) )
                                       \( d | d.iso8601       )
Time     = .Time     <iso8601> .String \( s | Time.iso8601(s) )
                                       \( t | t.iso8601       )
DateTime = .DateTime <iso8601> .String \( s | DateTime.iso8601(s) )
                                       \( t | t.iso8601           )
