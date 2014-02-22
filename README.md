[![Build Status](https://travis-ci.org/alf-tool/qrb.png)](https://travis-ci.org/alf-tool/qrb)
[![Dependency Status](https://gemnasium.com/alf-tool/qrb.png)](https://gemnasium.com/alf-tool/qrb)
[![Code Climate](https://codeclimate.com/github/alf-tool/qrb.png)](https://codeclimate.com/github/alf-tool/qrb)

# Qrb

*Q* is a language for capturing information structure. Think "JSON/XML schema"
but the correct way. Qrb is the ruby binding of *Q*. It allows defining Q schemas
and validating/coercing data against them in an idiomatic ruby way.

## Example

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

## Overview of Q

### Builtin types

A builtin type starts with a dot and is then denoted by the name of a Ruby
class. E.g.

```ruby
.Integer  # The set of values captured by Ruby's Integer class
```

Importing Q/builtins automatically defines type aliases for most ruby classes.
The dot notation can thus be avoided for them all. We make the assumption that
builtins are imported in the rest of this document and use the same class
names while getting rid of the dot.

### Sub types

Sub types are subsets of values. Q uses so-called 'specialization by
constraint' to define sub types. E.g., the set of positive integers can be
defined as follows:

```ruby
Posint = Integer( i | i >= 0 )
```

Multiple constraints can be distinguished by name:

```ruby
Evens = Integer( i | positive: i >= 0, even: i%2 == 0 )
```

All types can be sub-typed through constraints. In addition, Q uses structural
type equivalence, which means that the type captured by the definition of
`Evens` above is actually equivalent to the following one:

```ruby
Evens = PosInt( i | i % 2 == 0 )
```

### Union types

In some respect, union types are the dual of subtypes. They allow defining new
types by generalization, through the union of the set of values captured by
other types. For instance, the missing Boolean type of ruby is simply captured
as:

```ruby
Boolean = .TrueClass|.FalseClass
```

Union types are also very useful for capturing possibly missing information
(aka NULL/nil). For instance, the following type will capture either an
integer, or nil (note that `Nil = .NilClass`).

```
MaybeInt = Integer|Nil
```

### Seq types

Capturing sequences (aka arrays) of values is straightforward. Sequences are
ordered and may contain duplicates:

```ruby
Measures = [Posint]
```

### Set types

Capturing sets of values is straightforward too. Set are unordered and may not
contain duplicates:

```ruby
Hobbies = {String}
```

### Tuple types

Tuples capture information facts. Their 'structure' is called *heading* and is
fixed and known in advance. All attributes are mandatory:

```ruby
ProgrammingLanguage = { name: String, author: String, since: Date }
```

### Relation types

Relations are sets of tuples, all of same heading. The notation for defining
relation types naturally follows:

```ruby
Languages = {{ name: String, author: String, since: Date }}
```

Relation types and their syntax are first-class in Q, most notably because
of the availability of relational algebra for them, unlike pure sets of
tuples.

Note that relations do not allow duplicates and have no significant ordering
of their tuples. If the ordering is significant for you, want should consider
a sequence of tuples instead:

```ruby
Preferences = [{ lang: String, reason: String }]
```
