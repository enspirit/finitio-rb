Feature: Using Q to build formal document schemas

  Background:

    Given the document has been defined as follows:
      """
      {
        name: .String,
        color: { red: .Integer, green: .Integer, blue: .Integer },
        sex: .String( s | s =~ /^M|F$/ )
      }
      """

  Scenario: Validating data against valid document

    Given I use the document schema to validate the following JSON doc:
      """
      { "name": "Bernard Lambeau",
        "sex":  "M",
        "color": {
          "red": 12,
          "green": 14,
          "blue": 156
        }
      }
      """

    Then it should be a success

  Scenario: Validating data against an invalid document

    Given I use the document schema to validate the following JSON doc:
      """
      { "name": "Bernard Lambeau",
        "sex":  "M",
        "color": {
          "red": 12,
          "green": "bar",
          "blue": 156
        }
      }
      """

    Then it should be an TypeError as:
      | message                          | location    |
      | Invalid value `bar` for Integer  | color/green |
