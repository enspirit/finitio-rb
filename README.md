[![Build Status](https://travis-ci.org/blambeau/finitio-rb.png)](https://travis-ci.org/blambeau/finitio-rb)
[![Dependency Status](https://gemnasium.com/blambeau/finitio-rb.png)](https://gemnasium.com/blambeau/finitio-rb)
[![Code Climate](https://codeclimate.com/github/blambeau/finitio-rb.png)](https://codeclimate.com/github/blambeau/finitio-rb)
[![Coverage Status](https://coveralls.io/repos/blambeau/finitio-rb/badge.png?branch=master)](https://coveralls.io/r/blambeau/finitio-rb)

# Finitio(-rb)

*Finitio* is a language for capturing information structure. Think "JSON/XML
schema" but the right way. For more information about *Finitio* itself, see
[www.finitio.io](http://www.finitio.io)

`finitio-rb` is the ruby binding of *Finitio*. It allows defining data schemas
and validating and coercing data against them in an idiomatic ruby way.

## Example

```ruby
require 'finitio'
require 'json'

# Let load a schema
schema = Finitio::DEFAULT_SYSTEM.parse <<-FIO
  {
    name: String( s | s.strip.size > 0 ),
    at: DateTime
  }
FIO

# Let load some JSON document
data = JSON.parse <<-JSON
  { "name": "Finitio", "at": "20142-03-01" }
JSON

# And try dressing that data
puts schema.dress(data)
```

## ADTs with internal contracts

`finitio-rb` tries to provide an idiomatic binding for ruby developers. In
particular, it uses a simple convention-over-configuration protocol for
information contracts. This protocol is easily described through an example.
The following ADT definition:

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
extensions for instance), `finitio-rb` allows defining ADTs with external
contracts. The following ADT definition:

```ruby
Color = .Color <rgb> {r: Byte, g: Byte, b: Byte} .RgbContract
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

The `Rep` representation function mapping *Finitio* types to ruby classes is
as follows:

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

See `lib/finitio/Finitio/default.fio` for the precise definition of the default
system. In summary,

* Most ruby native (data) classes are already aliased to avoid explicit use of
  builtins. In particular, `Integer`, `String`, etc.
* A `Boolean` union type also hides the TrueClass and FalseClass distinction.
* Date, Time and DateTime ADTs are also provided that perform common
  conversions from JSON strings, through iso8601.
