Feature: Users management
    In order to manager customers
    As a store owner
    I want to be able to list registered users

    Background:
        Given I am logged in as administrator
        And the following zones are defined:
            | name         | type    | members                       |
            | German lands | country | Germany, Austria, Switzerland |
        And there are following users:
          | username | enabled | address                                                |
          | beth     | no      | Klaus Schmitt, Heine-Straße 12, 99734, Berlin, Germany |
          | martha   | yes     | Lars Meine, Fun-Straße 1, 90032, Vienna, Austria       |
          | rick     | no      | Klaus Schmitt, Heine-Straße 12, 99734, Berlin, Germany |
          | dale     | yes     | Lars Meine, Fun-Straße 1, 90032, Vienna, Austria       |
        And the following zones are defined:
          | name   | type    | members |
          | Poland | country | Poland  |
        And the following orders were placed:
          | user | address                                        |
          | john | Jan Kowalski, Wawel 5 , 31-001, Kraków, Poland |

    Scenario: Seeing index of all users
        Given I am on the dashboard page
         When I follow "Users"
         Then I should be on the user index page
          And I should see 6 users in the list

    Scenario: Seeing index of unconfirmed users
        Given I am on the user index page
         When I follow "Unconfirmed accounts"
         Then I should still be on the user index page
          But I should see 2 users in the list

    Scenario: Accessing the user details page from users list
        Given I am on the user index page
         When I click "details" near "john"
         Then I should be on the page of user with username "john"
          And I should see 1 orders in the list

    Scenario: Accessing the user editing form
        Given I am on the page of user with username "rick"
         When I follow "edit"
         Then I should be editing user with username "rick"

    Scenario: Accessing the editing form from the list
        Given I am on the user index page
         When I click "edit" near "rick"
         Then I should be editing user with username "rick"

    Scenario: Updating the user
        Given I am editing user with username "rick"
         When I fill in "Username" with "umpirsky"
          And I fill in "Email" with "umpirsky@gmail.com"
          And I press "Save changes"
         Then I should be on the page of user with username "umpirsky"
          And "User has been successfully updated." should appear on the page
          And "umpirsky@gmail.com" should appear on the page

    Scenario: Deleting user
        Given I am on the page of user with username "rick"
         When I press "delete"
         Then I should be on the user index page
          And I should see "User has been successfully deleted."

    Scenario: Deleted user disappears from the list
        Given I am on the page of user with username "rick"
         When I press "delete"
         Then I should be on the user index page
          And I should not see user with username "rick" in that list

    Scenario: Deleting user from the list
        Given I am on the user index page
         When I click "delete" near "rick"
         Then I should still be on the user index page
          And "User has been successfully deleted." should appear on the page
          But I should not see user with username "rick" in that list
