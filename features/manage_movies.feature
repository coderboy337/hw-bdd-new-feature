Feature: Manage movies
  As a user
  I want to be able to create and delete movies
  So that I can keep my movie database up to date

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |

  Scenario: Create a new movie
    Given I am on the home page
    When I follow "Add new movie"
    And I fill in "Title" with "Inception"
    And I select "PG-13" from "Rating"
    And I fill in "Director" with "Christopher Nolan"
    And I fill in "Release date" with "2010-07-16"
    And I press "Create Movie"
    Then I should see "Inception"
    And I should be on the home page

  Scenario: Delete a movie
    Given I am on the details page for "Alien"
    When I follow "Delete"
    Then I should be on the home page
    And I should not see "Alien"

