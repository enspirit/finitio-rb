Feature: Using Finitio High-Order types

  Background:

    Given the System is
      """
      Data<T,A> = {
        type       : T
        id         : Integer
        attributes : A
      }

      Resource<Type,Attrs> = {
        data  : Data<Type,Attrs>
        links : [String]
      }

      Collection<Type,Attrs> = {
        data  : [Data<Type,Attrs>]
        links : [String]
      }

      People.Type = String(s | s=="People")
      People.Attrs = {
        firstname: String
        lastname: String
      }

      People = Resource<People.Type,People.Attrs>
      Peoples = Collection<People.Type,People.Attrs>
      """

  Scenario: Coercing a valid representation of an object

    Given I dress the following JSON document with People:
      """
      {
        "data": {
          "type": "People",
          "id": 1,
          "attributes": {
            "firstname": "Bernard",
            "lastname": "Lambeau"
          }
        },
        "links": []
      }
      """

    Then it should be a success

  Scenario: Coercing a valid representation of a collection

    Given I dress the following JSON document with Peoples:
      """
      {
        "data": [{
          "type": "People",
          "id": 1,
          "attributes": {
            "firstname": "Bernard",
            "lastname": "Lambeau"
          }
        },{
          "type": "People",
          "id": 2,
          "attributes": {
            "firstname": "Yoann",
            "lastname": "Guyot"
          }
        }],
        "links": []
      }
      """

    Then it should be a success
