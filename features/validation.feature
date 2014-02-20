Feature: Using Q to validate input data

  Background:

    Given the Realm is built using the DSL as follows
       """
       Nil    = builtin(NilClass)
       Int    = builtin(Integer)
       String = builtin(String)
       Byte   = sub_type(Int, byte: ->(i){ i>=0 and i<=255 })
       Color  = tuple_type(r: Byte, g: Byte, b: Byte)
       Colors = relation_type(Color)
       """

  Scenario: Validating against a valid Color representation

    Given I validate the following JSON data against Color
      """
      { "r": 121, "g": 12, "b": 87 }
      """

    Then it should be a success
    And the result should be a Color ruby representation

  Scenario Outline: Validating against an invalid Color representation

    Given I validate the following JSON data against Color
      """
      <json>
      """
    Then it should be an UpError as:
      | message   | location   |
      | <msg>     | <loc>      |

    Examples:
      | json                                      | msg                          | loc |
      | { "r": 121, "g": 12 }                     | Missing attribute `b`        |     |
      | { "r": 121, "g": 12, "b": 255, "i": 143 } | Unrecognized attribute `i`   |     |
      | { "r": "foo", "g": 1, "b": 1 }            | Invalid value `foo` for Byte | r   |
      | { "r": -12, "g": 1, "b": 1 }              | Invalid value `-12` for Byte | r   |

  Scenario: Validating against a valid Colors representation

    Given I validate the following JSON data against Colors
      """
      [{ "r": 121, "g": 12, "b": 87 },
       { "r": 132, "g": 1,  "b": 12 }]
      """

    Then it should be a success
    And the result should be a Colors ruby representation

  Scenario: Validating against an invalid Colors representation

    Given I validate the following JSON data against Colors
      """
      [{ "r": 121, "g": 12, "b": 87 },
       { "r": 132, "g": -121,  "b": 12 }]
      """

    Then it should be an UpError as:
      | message                       | location |
      | Invalid value `-121` for Byte | 1/g      |
