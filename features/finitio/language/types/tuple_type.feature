Feature: Support for rich tuple types

  Scenario: Pure tuple types

    Given the System source is
      """
      { length: Integer, angle: Real }
      """
    Then it compiles to a tuple type
    And `length` and `angle` are mandatory
    And it does not allow extra attributes

  Scenario: Support for optional attributes

    Given the System source is
      """
      { length: Integer, angle :? Real }
      """
    Then it compiles to a tuple type
    And `length` is mandatory, but `angle` is optional
    And it does not allow extra attributes

  Scenario: Support for extra attributes

    Given the System source is
      """
      { length: Integer, ... }
      """
    Then it compiles to a tuple type
    And `length` is mandatory
    And it allows extra attributes
