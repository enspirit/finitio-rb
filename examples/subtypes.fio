# Some builtins on ruby classes
Int    = .Integer
String = .String
Real   = .Float

# Positive integers only
Posint = Int( i | i >= 0 )
Posint = Int( i | positive: i >= 0, small: i <= 255 )

# The traditional Byte
Byte = Int( i | i >= 0 and i <= 255 )

# A String capturing a color in hexadecimal notation
Color = String( s | s =~ /^#[0-9a-f]{6}$/i )

# A String of 10 characters
String( s | size(s) = 10 )

# A sequence of most 5 bytes
[Byte]( a | size(a) <= 5 )

# A sequence of exactly 5 bytes
[Byte]( a | size(a) = 5 )

# Either an array of bytes or an array of reals, but of at most 5 elements
([Byte]|[Real])( a | size(a) <= 5 )

# A tuple with two matching passwords
{
  pass: String,
  retry: String
}( t | t.pass = t.retry )
