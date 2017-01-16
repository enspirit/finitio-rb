# 0.5.1 / 2017-01-08

* Disable memoization in parser because it leads to terrible performance
  issues on some schemas.
* Avoid alternatives on high-level rules (Union, SubType) to prevent many
  fallbacks that kill performance without memoization enabled.

# 0.5.1 / 2015-09-22

* Enabled memoization in parser to avoid very long parsing time on complex
  schemas.

# 0.5.0 / 2015-09-18

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

# 0.4.1 / 2014-03-20

* Fixed access to the default system that lead to 'Unknown system
  Finitio/default (Finitio::Error)'

# 0.4.0 / 2014-03-20

* Finitio(-rb) is born from the sources of Q(rb) 0.3.0
* Finitio.parse now recognizes Path-like objects (responding to :to_path),
  allowing to parse files directly (through Pathname, Path, etc.).

# 0.3.0 / 2014-03-09

* Added AnyType abstraction, aka '.'
* Added support for external contracts in ADTs
* Added support for extracting an Abstract Syntax Tree from parsing result
* Allows camelCasing in constraint names

# 0.2.0 / 2014-03-04

* Fix dependencies in gemspec (judofyr)

# 0.1.0 / 2014-03-03

* Enhancements

  * Birthday!
