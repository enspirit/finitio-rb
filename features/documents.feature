Feature: Using Q to build formal document schemas

  Background:

    Given the document has been defined as follows:
      """
      Str    = .String
      Byte   = .Integer( i | i >= 0 and i <= 255 )
      Gender = <mf> Str( s | s == 'M' or s == 'F' )
      {
        name: Str,
        color: { red: Byte, green: Byte, blue: Byte },
        gender: Gender
      }
      """

  Scenario: Validating data against valid document

    Given I use the document schema to validate the following JSON doc:
      """
      {
        "name": "Bernard Lambeau",
        "gender":  "M",
        "color": {
          "red": 12,
          "green": 14,
          "blue": 156
        }
      }
      """

    Then it should be a success

  Scenario: Validating data against an invalid document (I)

    Given I use the document schema to validate the following JSON doc:
      """
      {
        "name": "Bernard Lambeau",
        "gender":  "M",
        "color": {
          "red": 12,
          "green": "bar",
          "blue": 156
        }
      }
      """

    Then it should be a TypeError as:
      | message                       | location    |
      | Invalid value `bar` for Byte  | color/green |

  Scenario: Validating data against an invalid document (II)

    Given I use the document schema to validate the following JSON doc:
      """
      {
        "name": "Bernard Lambeau",
        "gender":  "bar",
        "color": {
          "red": 12,
          "green": 14,
          "blue": 156
        }
      }
      """

    Then it should be a TypeError as:
      | message                        | location    |
      | Invalid value `bar` for Gender | gender      |
