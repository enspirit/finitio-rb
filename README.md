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
  { "name": "Q", "at": "20142-03-01" }
JSON

# And try dressing that data
puts schema.dress(data)
```

## ADTs with internal contracts

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

## ADTs with external contracts

When the scenario above is not possible or not wanted (would require core
extensions for instance), Qrb allows defining ADTs with external contracts.
The following ADT definition:

```ruby
Color = .Color <rgb> {r: Byte, g: Byte, b: Byte} RgbContract
```

expected the following ruby module:

```ruby
module RgbContract

  def self.dress(tuple)
    Color.new(tuple[:r], tuple[:g], tuple[:b])
  end

  def self.undress(color)
    { r: color.r, g: color.g, b: color.b }
  end

end
```

## About representations

The `Rep` representation function mapping Q types to ruby classes is as
follows:

```ruby
# Any type is represented by Ruby's Object class
Rep(.) = Object

# Builtins are represented by the corresponding ruby class
Rep(.Builtin) = Builtin

# Sub types are represented by the same representation as the super type
Rep(SuperType( s | ... )) = Rep(SuperType)

# Unions are represented by the corresponding classes. The guaranteed result
# class is thus the least common super class (^) of the corresponding
# representations of candidate types
Rep(T1 | ... | Tn) = Rep(T1) ^ ... ^ Rep(Tn)

# Sequences are represented through ::Array.
Rep([ElmType]) = Array<Rep(ElmType)>

# Sets are represented through ::Set.
Rep({ElmType}) = Set<Rep(ElmType)>

# Tuples are represented through ruby ::Hash. Attribute names are always
# symbolized
Rep({Ai => Ti}) = Hash<Symbol => Rep(Ti)>

# Relations are represented through ruby ::Set of ::Hash.
Rep({{Ai => Ti}}) = Set<Hash<Symbol => Rep(Ti)>>

# Abstract data types are represented through the corresponding class when
# specified. ADTs behave as Union types if no class is bound.
Rep(.Builtin <rep> ...) = Builtin
```

## About the default system

See `lib/qrb/Q/default.q` for the precise definition of the default system.
In summary,

* Most ruby native (data) classes are already aliased to avoid explicit use of
  builtins. In particular, `Integer`, `String`, etc.
* A `Boolean` union type also hides the TrueClass and FalseClass distinction.
* Date, Time and DateTime ADTs are also provided that perform common
  conversions from JSON strings, through iso8601.
