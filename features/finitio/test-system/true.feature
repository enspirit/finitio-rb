Feature: TestSystem.True

  Background:
    Given the type under test is True

  Scenario: Against true

    Given I dress JSON's 'true'
    Then the result should be a representation for True
    Then the result should be a representation for Boolean
    And the result should be the Boolean true

  Scenario: Against false

    Given I dress JSON's 'false'
    Then it should be a TypeError as:
      | message                        |
      | Invalid True `false`           |

  Scenario: Against null

    Given I dress JSON's 'null'
    Then it should be a TypeError as:
      | message                       |
      | Invalid True `null`           |

  Scenario: Against an arbitrary value

    Given I dress JSON's '12'
    Then it should be a TypeError as:
      | message                     |
      | Invalid True `12`           |
