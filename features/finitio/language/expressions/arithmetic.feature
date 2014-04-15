Feature: Support for base arithmetic

  Background:
    Given the grammar rule is expr

  Scenario Outline: +

    Given the source is
      """
      x + 12
      """
    Then evaluating it with x=<x> should yield <expected>

    Examples:
      | x   | expected |
      | -12 |        0 |
      |   0 |       12 |
      |  12 |       24 |

  Scenario Outline: -

    Given the source is
      """
      x - 12
      """
    Then evaluating it with x=<x> should yield <expected>

    Examples:
      | x   | expected |
      | -12 |      -24 |
      |   0 |      -12 |
      |  12 |        0 |

  Scenario Outline: *

    Given the source is
      """
      x * 12
      """
    Then evaluating it with x=<x> should yield <expected>

    Examples:
      | x   | expected |
      | -12 |     -144 |
      |   0 |        0 |
      |  12 |      144 |

  Scenario Outline: /

    Given the source is
      """
      x / 12
      """
    Then evaluating it with x=<x> should yield <expected>

    Examples:
      | x    | expected |
      | -144 |      -12 |
      |    0 |        0 |
      |  144 |       12 |

  Scenario Outline: priority of mult over add

    Given the source is
      """
      x <mult> 12 <add> 1
      """
    Then evaluating it with x=<x> should yield <expected>

    Examples:
      | mult | add | x    | expected |
      |    * |   + | 10   |      121 |
      |    * |   - | 10   |      119 |
      |    / |   + | 144  |       13 |
      |    / |   - | 144  |       11 |

  Scenario Outline: priority of parentheses

    Given the source is
      """
      x <mult> (12 <add> 1)
      """
    Then evaluating it with x=<x> should yield <expected>

    Examples:
      | mult | add | x    | expected |
      |    * |   + | 10   |      130 |
      |    * |   - | 10   |      110 |
      |    / |   + | 169  |       13 |
      |    / |   - | 121  |       11 |

  Scenario: multiple multiplications

    Given the source is
      """
      4 * 2 * 3
      """
    Then evaluating it should yield 24

  Scenario: multiple additions

    Given the source is
      """
      4 + 2 + 3
      """
    Then evaluating it should yield 9
