Feature: Support for integer literals

  Background:
    Given the grammar rule is literal

  Scenario Outline: Parsing integer literals

    Given the source is
      """
      <source>
      """
    Then it evaluates to a <type>

    Examples:
      | source |    type | 
      |      0 | Integer |
      |     10 | Integer |
      |   1024 | Integer |
