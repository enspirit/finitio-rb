Feature: Using Q to validate input data

  Background:

    Given the Realm is
       """
       Nil    = .NilClass
       Int    = .Integer
       String = .String
       Byte   = Int( i | i>=0 and i<=255 )
       Color  = { r: Byte, g: Byte, b: Byte }
       Colors = {{ r: Byte, g: Byte, b: Byte }}
       """

  Scenario: Validating against a valid Color representation

    Given I validate the following JSON data against Color
      """
      { "r": 121, "g": 12, "b": 87 }
      """

    Then it should be a success
    And the result should be a Color native representation

  Scenario: Validating an incomplete Color representation

    Given I validate the following JSON data against Color
      """
      { "r": 121, "g": 12 }
      """

    Then it should be a TypeError as:
      | message               | location |
      | Missing attribute `b` |          |

  Scenario: Validating a Color representation with extra attributes

    Given I validate the following JSON data against Color
      """
      { "r": 121, "g": 12, "b": 255, "i": 143 }
      """

    Then it should be a TypeError as:
      | message                    | location |
      | Unrecognized attribute `i` |          |

  Scenario: Validating a Color representation with an invalid attribute type

    Given I validate the following JSON data against Color
      """
      { "r": "foo", "g": 12, "b": 255 }
      """

    Then it should be a TypeError as:
      | message                      | location |
      | Invalid value `foo` for Byte | r        |


  Scenario: Validating a Color representation with an invalid value

    Given I validate the following JSON data against Color
      """
      { "r": -12, "g": 12, "b": 255 }
      """

    Then it should be a TypeError as:
      | message                      | location |
      | Invalid value `-12` for Byte | r        |

  Scenario: Validating against a valid Colors representation

    Given I validate the following JSON data against Colors
      """
      [{ "r": 121, "g": 12, "b": 87 },
       { "r": 132, "g": 1,  "b": 12 }]
      """

    Then it should be a success
    And the result should be a Colors native representation

  Scenario: Validating against an invalid Colors representation

    Given I validate the following JSON data against Colors
      """
      [{ "r": 121, "g": 12, "b": 87 },
       { "r": 132, "g": -121,  "b": 12 }]
      """

    Then it should be a TypeError as:
      | message                       | location |
      | Invalid value `-121` for Byte | 1/g      |
