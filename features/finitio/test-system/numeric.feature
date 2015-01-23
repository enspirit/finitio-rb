Feature: TestSystem.Numeric

  Background:
    Given the type under test is Numeric

  Scenario: Against an integer

    Given I dress JSON's '12'
    Then the result should be a representation for Numeric
    And  the result should be the integer 12

  Scenario: Against a real

    Given I dress JSON's '12.5'
    Then the result should be a representation for Numeric
    And  the result should be the real 12.5

  Scenario: Against an integer literal

    Given I dress JSON's '"12"'
    Then it should be a TypeError as:
      | message                        |
      | Invalid Numeric `12`           |

  Scenario: Against null

    Given I dress JSON's 'null'
    Then it should be a TypeError as:
      | message                          |
      | Invalid Numeric `null`           |

  Scenario: Against an arbitrary value

    Given I dress JSON's '"foo"'
    Then it should be a TypeError as:
      | message                          |
      | Invalid Numeric `foo`            |
