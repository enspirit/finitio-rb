Feature: TestSystem.String

  Background:
    Given the type under test is String

  Scenario: Against a string

    Given I dress JSON's '"foo"'
    Then the result should be a representation for String
    And the result should be the string 'foo'

  Scenario: Against null

    Given I dress JSON's 'null'
    Then it should be a TypeError as:
      | message                         |
      | Invalid String `null`           |

  Scenario: Against true

    Given I dress JSON's 'true'
    Then it should be a TypeError as:
      | message                         |
      | Invalid String `true`           |

  Scenario: Against an integer

    Given I dress JSON's '12'
    Then it should be a TypeError as:
      | message                       |
      | Invalid String `12`           |
