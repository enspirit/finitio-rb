Feature: Missing information Using Q

  Background:

    Given the System is
       """
       MaybeInt = Nil|Integer
       """

   Scenario: Validating non nil against Integer

    Given I dress the following JSON document with Integer:
      """
       12
       """

     Then it should be a success
     And the result should equal 12

  Scenario: Validating nil against Integer

    Given I dress the following JSON document with Integer:
      """
      null
      """

    Then it should be a TypeError as:
      | message                         |
      | Invalid value `nil` for Integer |

  Scenario: Validating nil against MaybeInt

    Given I dress the following JSON document with MaybeInt:
      """
      null
      """

    Then it should be a success
    And the result should be a representation for Nil
