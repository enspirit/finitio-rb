Feature: Support for boolean literals

  Background:
    Given the grammar rule is literal

  Scenario Outline: Parsing boolean literals

    Given the source is
      """
      <source>
      """
    Then it evaluates to a <type>

    Examples:
      | source |    type | 
      |   true | Boolean |
      |  false | Boolean |
