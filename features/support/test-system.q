Any = .
Nil = .NilClass

# Booleans
True    = .TrueClass
False   = .FalseClass
Boolean = True|False

# Numerics
Numeric = .Numeric
Real    = .Float
Integer = .Integer

# String
String  = .String

# Dates and Time
Date     = .Date     <iso8601> .String \( s | Date.iso8601(s) )
                                       \( d | d.iso8601       )
Time     = .Time     <iso8601> .String \( s | Time.iso8601(s) )
                                       \( t | t.iso8601       )
