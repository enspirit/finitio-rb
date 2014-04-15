Feature: Support for comparisons

  Background:
    Given the grammar rule is expr

  Scenario Outline: ==

    Given the source is
      """
      x == 12
      """
    Then evaluating it with x=<x> should yield <expected>

    Examples:
      | x  | expected |
      |  0 |    false |
      | 12 |     true |
      | 13 |    false |

  Scenario Outline: !=

    Given the source is
      """
      x != 12
      """
    Then evaluating it with x=<x> should yield <expected>

    Examples:
      | x  | expected |
      |  0 |     true |
      | 12 |    false |
      | 13 |     true |

  Scenario Outline: <=

    Given the source is
      """
      x <= 12
      """
    Then evaluating it with x=<x> should yield <expected>

    Examples:
      | x  | expected |
      |  0 |     true |
      | 11 |     true |
      | 12 |     true |
      | 13 |    false |

  Scenario Outline: <

    Given the source is
      """
      x < 12
      """
    Then evaluating it with x=<x> should yield <expected>

    Examples:
      | x  | expected |
      |  0 |     true |
      | 11 |     true |
      | 12 |    false |
      | 13 |    false |

  Scenario Outline: >=

    Given the source is
      """
      x >= 12
      """
    Then evaluating it with x=<x> should yield <expected>

    Examples:
      | x  | expected |
      |  0 |    false |
      | 11 |    false |
      | 12 |     true |
      | 13 |     true |

  Scenario Outline: >

    Given the source is
      """
      x > 12
      """
    Then evaluating it with x=<x> should yield <expected>

    Examples:
      | x  | expected |
      |  0 |    false |
      | 11 |    false |
      | 12 |    false |
      | 13 |     true |
