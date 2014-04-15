Feature: Support for string literals

  Background:
    Given the grammar rule is literal

  Scenario Outline: Parsing string literals

    Given the source is
      """
      <source>
      """
    Then it should compile to a <type>

    Examples:
      |              source | type   |
      |                  "" | String |
      |           "Finitio" | String |
      | "Hello \"Finitio\"" | String |
