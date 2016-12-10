Feature: Create a new board
In order to manage my projects
As a project manager
I want to create a new board

Scenario: Try to create a new board without a title
  Given I'm creating a board with an empty title
  Then I should see the "can't be blank" error on the "title" field

Scenario: Create a new board with a title but no description
  Given I'm creating a board with a title
  Then the board should be created

Scenario: Create a new board with a title and a description
  Given I'm creating a board with a title and a description
  Then the board should be created
