[![Integration](https://github.com/enspirit/finitio-rb/actions/workflows/integration.yml/badge.svg?branch=master)](https://github.com/enspirit/finitio-rb/actions/workflows/integration.yml)
[![Gem Version](https://badge.fury.io/rb/finitio.svg)](https://rubygems.org/gems/finitio)
[![Coverage Status](https://coveralls.io/repos/github/enspirit/finitio-rb/badge.svg?branch=master)](https://coveralls.io/github/enspirit/finitio-rb?branch=master)

# Finitio(-rb)

*Finitio* is a language for capturing information structure. Think "JSON/XML
schema" but the right way. For more information about *Finitio* itself, see
[www.finitio.io](http://www.finitio.io)

`finitio-rb` is the ruby binding of *Finitio*. It allows defining data schemas
and validating and coercing data against them in an idiomatic ruby way.

## Installation

```
gem install finitio
```

or, in a `Gemfile`:

```ruby
gem 'finitio', '~> 1.0'
```

`finitio-rb` requires Ruby 3.2 or later, and is tested against 3.2, 3.3, 3.4
and 4.0.

## Example

```ruby
require 'finitio'
require 'json'

# Let load a schema
schema = Finitio.system <<-FIO
  @import finitio/data

  {
    name: String( s | s.strip.size > 0 ),
    at: DateTime
  }
FIO

# Let load some JSON document
data = JSON.parse <<-JSON
  { "name": "Finitio", "at": "2014-03-01T12:00:00Z" }
JSON

# And try dressing that data
puts schema.dress(data)
```

Dressing either returns the data coerced to its ruby representation -- here,
`at` comes back as a real `DateTime` -- or raises a `Finitio::TypeError`
explaining what does not match:

```ruby
schema.dress({ "name" => "  ", "at" => "2014-03-01T12:00:00Z" })
# => Finitio::TypeError: Invalid Default `  `
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

## Decompose complex system with imports

It is useful to decompose complex systems in many files using the import
feature. The latter works with relative file paths like this:

```
# child.fio

Posint = .Integer(i | i >= 0)
```

```
# parent.fio
@import ./child

# Child's types are available inside the system, but not outside it, that
# is, imported types are not themselves exported
Byte = Posint(i | i <= 255 )
```

```
@import ./parent

# This will work
HalfByte = Byte(i | i <= 128)

# But this will not: Posint is not defined
Posint(i | i <= 128)
```

Note that the path is written **without** the `.fio` extension: the resolver
appends it, so `@import ./child.fio` looks for `child.fio.fio` and fails.

Relative paths are resolved against the file the system was loaded from, so
the schema has to come from one — `Finitio.system(Pathname.new('parent.fio'))`
rather than `Finitio.system(File.read('parent.fio'))`, which has no path to
resolve against.

See the next section about the standard library if you need to share types
without relying on relative paths.

## Standard library

Usual type definitions are already defined for simple data types, forming
Finitio's default system:

* Most ruby native (data) classes are already aliased to avoid explicit use of
  builtins. In particular, `Integer`, `String`, etc.

* A `Boolean` union type also hides the TrueClass and FalseClass distinction.

* Date, Time and DateTime ADTs are also provided that perform common
  conversions from JSON strings, through iso8601.

This system is best used through Finitio's so-called "standard library", e.g.

```
@import finitio/data

# String, Integer, Boolean, etc. are now available in this system
```

See `lib/finitio/stdlib/*.fio` for the precise definition of the standard library.

### Contributing to the standard library

Ruby gems may contribute to the standard library by specifying resolve paths.
We suggest the following system file structure inside your gem source code:

```
lib
  myrubygem
  myrubygem.rb
finitio
  myrubygem
    base.fio
    advanced.fio
```

Registering the standard library path can then be done as follows:

```
# inside myrubygem.rb
Finitio.stdlib_path(File.expand_path('../../finitio', __FILE__))
```

Then, a Finitio schema will have access to the types defined in your extension:

```
@import myrubygem/base
@import myrubygem/advanced
```

## Generating a JSON Schema

Finitio types can be projected to a JSON Schema, which is useful to expose a
schema to consumers that do not speak Finitio (API documentation, client-side
validation, ...). The feature ships in a separate file, to be required
explicitly:

```ruby
require 'finitio'
require 'finitio/json_schema'

schema = Finitio.system <<-FIO
  @import finitio/data

  Person = { name: String, age: Integer }
  Person
FIO

schema.fetch('Person').to_json_schema
# => {
# =>   type: "object",
# =>   properties: {
# =>     name: { type: "string" },
# =>     age:  { type: "integer" }
# =>   },
# =>   required: ["name", "age"]
# => }
```

The projection is necessarily lossy: JSON Schema cannot express Finitio's
constraints, ADTs or recursive types faithfully. Two metadata attributes let
you steer it:

* `description` on an attribute is carried over to the generated schema.
* `jsonSchemaType` on a type stops the generation there and uses the given
  type as-is, which is the way out for types that have no useful projection.

## Generating data

`Finitio::Generation` produces random data conforming to a type, which is
handy for tests and fixtures:

```ruby
require 'finitio'
require 'finitio/generation'

Finitio::Generation.new.call(schema.fetch('Person'))
# => { name: "e6f4a1c0b2d3", age: 418561 }
```

Generation can be fine-tuned by passing generators by type name, or through
`examples` metadata on the type definitions themselves. See
`lib/finitio/generation.rb` for the available options.

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
