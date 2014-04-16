Feature: Support for rich relation types

  Scenario: Pure relation types

    Given the System is
      """
      {{ length: Integer, angle: Real }}
      """
    Then it compiles to a relation type
    And `length` and `angle` are mandatory
    And it does not allow extra attributes

  Scenario: Support for optional attributes

    Given the System is
      """
      {{ length: Integer, angle :? Real }}
      """
    Then it compiles to a relation type
    And `length` is mandatory, but `angle` is optional
    And it does not allow extra attributes

  Scenario: Support for extra attributes

    Given the System is
      """
      {{ length: Integer, ... }}
      """
    Then it compiles to a relation type
    And `length` is mandatory
    And it allows extra attributes
