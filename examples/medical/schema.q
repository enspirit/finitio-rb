# Mapping with the host language (can be provided by Qrb itself)
Boolean = .TrueClass|.FalseClass
String  = .String
Real    = .Float
Integer = .Fixnum
Date    = .Date <iso8601> .String \( s | Date.iso8601(s) )
                                  \( t | t.iso8601 )
Time    = .Time <iso8601> .String \( s | DateTime.parse(s) )
                                  \( t | t.iso8601 )

# Some reusable data types (could be reused across schemas)
Uuid     = String( s | s.size == 36 )
Dose     = <as> Real( f |  f >= 0.0 and f <= 1.0 )
Gender   = <as> String( s | s == 'M' or s == 'F' )
Duration = .Duration <minutes> Integer( i | i > 0 )
Name     = String( s | s.strip.size > 0 )

# The main schema, for instance for a RESTful resource or a NoSQL
# database
{{
  id: Uuid,
  diagnosis_date: Date,
  patient: {
    id: Uuid,
    name: Name,
    gender: Gender
  },
  appointments: {{
    at: Time,
    duration: Duration,
    fixed: Boolean
  }}
}}
