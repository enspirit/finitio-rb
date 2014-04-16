Feature: Support for real literals

  Background:
    Given the grammar rule is literal

  Scenario Outline: Parsing real literals

    Given the source is
      """
      <source>
      """
    Then it evaluates to a <type>

    Examples:
      | source | type |
      |     .0 | Real |
      |    0.0 | Real |
      |  0.000 | Real |
      | 0.0001 | Real |
      | 0.1024 | Real |
      |  .1024 | Real |
      |  1.024 | Real |
      |  10.24 | Real |
