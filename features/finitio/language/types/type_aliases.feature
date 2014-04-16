Feature: Support for type aliases

  Scenario: Aliasing a named type

    Given the System is
      """
      Posint = Integer( i | i>0 )
      Alias  = Posint
      """
    Then it compiles fine

