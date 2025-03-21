## 0.12.2

* Don't generate anyOf with duplicate types in JsonSchema geneation.

## 0.12.1 - 2025/03/20

* Allow Hash as bulttin type recognized by JsonSchema generation.
* Remove Ruby 2.6 from supported versions. Requirement is Ruby 2.7.

## 0.12.0 - 2023/05/23

* Remove support for ruby < 2.6

* Remove support for .Fixnum and .Bignum, .Integer is now used
  everywhere. To ease the transition, Fixum and Bignum still exist
  in the finitio/data stdlib schema, but will be removed in 0.13.x

## 0.11.4 - 2023/01/06

* The proxy resolution is fixed and clarified. When compiling
  a system, all proxies are actually replaced by their actual
  Type instance. Only recursive types still keep ProxyType
  instances (as sentinels) ; they are bound to their target
  type and delete dress and include? to them.

  Given that ProxyType is a sentinel on recursive types, calls
  to generate_data and to_json_schema are not delegated to the
  target type, to avoid infinite recursions.

* Generated names of instantiated high order types are better
  (e.g. Collection<String>).

## 0.11.3 - 2023/01/06

* Fix json_schema generation on unresolved ProxyTypes. We use
  "object" by default, waiting for a better support for recursive
  types.

## 0.11.2 - 2023/01/06

* Fix json_schema generation on builtin_type NilClass. "null"
  is not a valid value, we now use "string" instead.

## 0.11.1 - 2021/12/09

* Fix github actions and extend test grid.

## 0.11.0 - 2021/12/09

* Fix json schema generation of Boolean and union types with a |Nil
* Add support for dashses in attribute names (tuple & relation types).

## 0.10.0 - 2021/01/11

* Upgrade all dependencies.

* Ruby < 2.3 is no longer supported.

* Fix code and build under Ruby 3.0.

## 0.9.1 - 2020/12/24

* Fixes a bug where proxy types are not properly resolved when used
  in a heading extra, e.g. `{ ...: Proxy }`

## 0.9.0 - 2020/12/16

* Add Type#to_json_schema that converts Finitio types to JSON schema
  representations. This first implementation skips all constraints on sub types,
  though. You need to explicitly require 'finitio/json_schema' to use it.

## 0.8.0 - 2019/10/21

* Add `Type#unconstrained` that returns a super type with all user specific
  constraints removed on sub types, recursively on all non scalar types.

* Add high-order types, such as `Collection<T> = [T]`

* Add support for random data generation through `Finitio::Generation`.
  Please `require 'finitio/generation'` to use it.

## 0.7.0 / 2019-02-28

* Implement (basic) @import feature, working with relative paths
  and a standard library. The standard library systems are memoized
  to avoid unnecessary parsing and compilation.

* `System#check_and_warn` allows discovering warnings, infos and
  errors in system definitions, such as duplicate type definitions
  and import overrides.

* WARN: Finitio::DEFAULT_SYSTEM is deprecated. Use @import
  finitio/data instead.

## 0.6.1 / 2018-03-23

* Fix support for typed extra attributes, a KeyError was raised when
  keys were Symbols and not Strings.

## 0.6.0 / 2018-02-17

* Add support for typed extra attributes, e.g. { ...: Integer }

## 0.5.2 / 2017-01-08

* Disable memoization in parser because it leads to terrible performance
  issues on some schemas.
* Avoid alternatives on high-level rules (Union, SubType) to prevent many
  fallbacks that kill performance without memoization enabled.

## 0.5.1 / 2015-09-22

* Enabled memoization in parser to avoid very long parsing time on complex
  schemas.

## 0.5.0 / 2015-09-18

* Breaking changes on public API

  * Finitio.parse now returns the parsing tree, no longer the compiled system,
    use Finitio.system instead.

  * Dress error messages have been changed from `Invalid value xxx for Type` to
    a more friendly `Invalid Type xxx`. The rationale is that end-users might
    be exposed to those messages in practice. The new messages seem less cryptic.

* Major enhancements

  * Types no longer have to declared before being used. In order words, the
    following will work fine even if Bigint references Posint that is declared
    afterwards:

        ```
        Bigint = Posint( i | i >= 255 )
        Posint = Integer( i | i >= 0 )
        { length: Bigint }
        ```

  * Added support for recursive types, e.g.,

        ```
        Tree = { label: String, children: [Tree] }
        ```

  * Added support for MultiTuple and MultiRelation types, aka "optional
    vs. required attributes". In the following system, `Person` is a multi
    tuple while `Persons` is a multi relation; the date of birth is optional
    in both cases:

        ```
        Person  =  { name : String, dob :? Date }
        Persons = {{ name : String, dob :? Date }}
        ```

  * Added basic support for namespacing, through dots being now allowed in
    type names. More namespacing support will be added later.


        ```
        This.Is.A.NameSpaced.Type = .Integer( i | i >= 0 )
        { length: This.Is.A.NameSpaced.Type }
        ```

  * Attribute names can now start with an underscore, e.g. '_links'

  * Error now have an `root_cause` helper.

  * Dress errors resulting from Union and AdType now set a cause to the first
    error encountered during the various attempts to dress.

* Breaking changes on undocumented APIs

  * Removed factory methods from the Finitio module itself. Use a System
    instance instead.
  * Removed Finitio::DataType

* Other changes & Bug fixes

  * Make Finitio compatible with both Citrus 2.4.x and Citrus 3.x
  * Fixed parsing of constraint expressions having inner parentheses

## 0.4.1 / 2014-03-20

* Fixed access to the default system that lead to 'Unknown system
  Finitio/default (Finitio::Error)'

## 0.4.0 / 2014-03-20

* Finitio(-rb) is born from the sources of Q(rb) 0.3.0
* Finitio.parse now recognizes Path-like objects (responding to :to_path),
  allowing to parse files directly (through Pathname, Path, etc.).

## 0.3.0 / 2014-03-09

* Added AnyType abstraction, aka '.'
* Added support for external contracts in ADTs
* Added support for extracting an Abstract Syntax Tree from parsing result
* Allows camelCasing in constraint names

## 0.2.0 / 2014-03-04

* Fix dependencies in gemspec (judofyr)

## 0.1.0 / 2014-03-03

* Enhancements

  * Birthday!
