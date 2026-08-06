Feature: TupleType with extra

  Finitio exists to give guarantees about data, and dressing only carries
  through what it can vouch for.

  A tuple that says nothing about extra attributes rejects them outright. An
  untyped `...` accepts them but constrains them in no way, so they are
  dropped rather than carried through unchecked. A typed `...: Age` does
  constrain them, so they are dressed and kept like any declared attribute.

  Background:

    Given the System is
      """
      Age        = Integer( i | i>=0 )
      Strict     = { name: String }
      Info       = { name: String, ... }
      Guaranteed = { name: String, ...: Age }
      """

  Scenario: A tuple with no extra clause rejects extra attributes

    Given I dress JSON's '{ "name": "Finitio", "age": 1 }' with Strict
    Then it should be a TypeError as:
      | message                      |
      | Unrecognized attribute `age` |

  Scenario: An untyped `...` accepts extra attributes

    Given I dress JSON's '{ "name": "Finitio", "age": 1, "foo": 42 }' with Info
    Then the result should be a representation for Info

  Scenario: An untyped `...` drops the extra attributes it cannot vouch for

    Given I dress JSON's '{ "name": "Finitio", "age": 1, "foo": 42 }' with Info
    Then the result should equal JSON's '{ "name": "Finitio" }'
    And the result should not have a 'age' attribute
    And the result should not have a 'foo' attribute

  Scenario: An untyped `...` drops extra attributes whatever their value

    Given I dress JSON's '{ "name": "Finitio", "age": "not a number" }' with Info
    Then the result should equal JSON's '{ "name": "Finitio" }'

  Scenario: A typed `...` keeps the extra attributes it guarantees

    Given I dress JSON's '{ "name": "Finitio", "age": 1, "size": 42 }' with Guaranteed
    Then the result should equal JSON's '{ "name": "Finitio", "age": 1, "size": 42 }'

  Scenario: A typed `...` rejects extra attributes that break its guarantee

    Given I dress JSON's '{ "name": "Finitio", "age": -1 }' with Guaranteed
    Then it should be a TypeError as:
      | message          | location |
      | Invalid Age `-1` | age      |

  Scenario: Dressing when a declared attribute is missing

    Given I dress JSON's '{ "age": 42, "foo": 42 }' with Info
    Then it should be a TypeError as:
      | message                  |
      | Missing attribute `name` |
