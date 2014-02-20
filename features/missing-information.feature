Feature: Missing information Using Q

  Background:

    Given the Realm is built using the DSL as follows
       """
       Nil      = builtin(NilClass)
       Int      = builtin(Integer)
       MaybeInt = union_type(Nil, Int)
       """

  Scenario: Validating nil against Int

    Given I validate the following JSON data against Int
      """
      null
      """

    Then it should be an UpError as:
      | message                          |
      | Invalid value `nil` for Integer  |

  Scenario: Validating nil against MaybeInt

    Given I validate the following JSON data against MaybeInt
      """
      null
      """

    Then it should be a success
    And the result should be the null representation in the host language
