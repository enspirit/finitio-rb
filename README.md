[![Build Status](https://travis-ci.org/blambeau/qrb.png)](https://travis-ci.org/blambeau/qrb)
[![Dependency Status](https://gemnasium.com/blambeau/qrb.png)](https://gemnasium.com/blambeau/qrb)
[![Code Climate](https://codeclimate.com/github/blambeau/qrb.png)](https://codeclimate.com/github/blambeau/qrb)
[![Coverage Status](https://coveralls.io/repos/blambeau/qrb/badge.png?branch=master)](https://coveralls.io/r/blambeau/qrb)

# Qrb

*Q* is a language for capturing information structure. Think "JSON/XML schema"
but the correct way. For more information about *Q* itself, see [www.q-lang.io](http://www.q-lang.io)

Qrb is the ruby binding of *Q*. It allows defining Q schemas and validating
and coercing data against them in an idiomatic ruby way.

## Example

```ruby
require 'qrb'
require 'json'

# Let load a Q schema
schema = Qrb::DEFAULT_SYSTEM.parse <<-Q
  {
    name: String( s | s.strip.size > 0 ),
    at: DateTime
  }
Q

# Let load some JSON document
data = JSON.parse <<-JSON
  { "name": "Q", at: "20142-03-01" }
JSON

# And try dressing that data
schema.dress(data)
```

## About this Q binding

Qrb tries to provide an idiomatic binding for ruby developers. In particular,
it uses a simple convention-over-configuration protocol for information
contracts. This protocol is easily described through an example. The following
ADT definition:

```ruby
Color = .Color <rgb> {r: Byte, g: Byte, b: Byte}
```

expects the following ruby class:

```ruby
class Color

  # Constructor & internal representation
  def initialize(r, g, b)
    @r, @g, @b = r, g, b
  end
  attr_reader :r, :g, :b

  # Public dresser for the RGB information contract on the class
  def self.rgb(tuple)
    new(tuple[:r], tuple[:g], tuple[:b])
  end

  # Public undresser on the instance
  def to_rgb
    { r: @r, g: @g, b: @b }
  end

  # ...

end
```

## About the default system

See `lib/qrb/Q/default.q` for the precise definition of the default system.
In summary,

* Most ruby native (data) classes are already aliased to avoid explicit use of
  builtins. In particular, `Integer`, `String`, etc.
* A `Boolean` union type also hides the TrueClass and FalseClass distinction.
* Date, Time and DateTime ADTs are also provided that perform common
  conversions from JSON strings, through iso8601.
