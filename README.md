[![Build Status](https://travis-ci.org/alf-tool/qrb.png)](https://travis-ci.org/alf-tool/qrb)
[![Dependency Status](https://gemnasium.com/alf-tool/qrb.png)](https://gemnasium.com/alf-tool/qrb)
[![Code Climate](https://codeclimate.com/github/alf-tool/qrb.png)](https://codeclimate.com/github/alf-tool/qrb)

# Qrb

*Q* is a language for capturing information structure. Think "JSON/XML schema"
but the correct way. Qrb is the ruby binding of *Q*. It allows defining Q schemas
and validating/coercing data against them in an idiomatic ruby way.

## Overview of Q

Suppose we want to capture information about a medical diagnosis for some patient.
A digital document could look like, e.g. in JSON:

```json
{
  "patient": {
    "id": "27b3ceb0-7e10-0131-c9f1-3c07545ed162",
    "name": "Marcia Delgados",
    "date_of_birth": "1975-11-03"
  },
  "symptoms": [
    "Nausea",
    "Fever"
  ],
  "temperature": 39.5
}
```

In Q, a schema for such a document would look like this:

```ruby
# Import the default types from Q. This binds the Uuid, String and Date
# types used later.
import 'Q/builtins';

# Define a temperature type, represented as a Real with a  typical range
# constraint
Temperature = <celcius> Real( f | f >= 33.0 and f <= 45.0 )

# Schema description, a single Tuple
{
  # The patient information is an inner Tuple. We only allow dates of birth of
  # alive patients.
  patient: {
    id: Uuid,
    name: String( s | s.size > 0 ),
    date_of_birth: Date( d | alive: d.year > 1890 ),
  },

  # Some symptoms, an array, possibly empty, of non empty strings
  symptoms: [ String( s | s.size > 0 ) ],

  # And the temperature, as defined previously
  temperature: Temperature
}
```

Now, let suppose that an invalid document comes in, e.g.

```json
{
  "patient": {
    "id": "27b3ceb0-7e10-0131-c9f1-3c07545ed162",
    "date_of_birth": "1875-11-03"
  },
  "symptoms": [
    "Nausea",
    ""
  ],
  "temperature": 12.5
}
```

You obtain the following errors:

```
[patient] Missing attribute `name`
[patient/date_of_birth] Invalid value `1875-11-03` for Date (not alive)
[symptoms/1] Invalid value "" for String( s | s.size > 0 )
[temperature] Invalid value 12.5 for Temperature (celcius)
```
