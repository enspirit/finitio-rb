Feature: Missing information Using Q

  Background:

    Given the System is
       """
       Nil      = .NilClass
       Int      = .Integer
       MaybeInt = Nil|Int
       """

   Scenario: Validating non nil against Int

     Given I validate the following JSON data against Int
       """
       12
       """

     Then it should be a success
     And the result should equal 12

  Scenario: Validating nil against Int

    Given I validate the following JSON data against Int
      """
      null
      """

    Then it should be a TypeError as:
      | message                      |
      | Invalid value `nil` for Int  |

  Scenario: Validating nil against MaybeInt

    Given I validate the following JSON data against MaybeInt
      """
      null
      """

    Then it should be a success
    And the result should be a Nil representation
