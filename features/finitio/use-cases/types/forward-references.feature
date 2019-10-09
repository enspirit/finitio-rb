Feature: Recursive type

  Background:

    Given the System is
      """
      WithForward = PosInt
      PosInt = Integer(i | i>0)
      { x: WithForward }
      """

  Scenario: Dressing valid data

    Given I dress the following JSON document:
      """
      {
        "x": 12
      }
      """

    Then it should be a success
