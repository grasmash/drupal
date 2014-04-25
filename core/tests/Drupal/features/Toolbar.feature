Feature: Toolbar
  The toolbar provides link for site administrators.

  @api @javascript
  Scenario: Toolbar submenus appear when parent menu item is clicked
    Given I am logged in as a user with the "administrator" role
    When I click "Manage"
    Then I should see "Content"
    When I click "Shortcuts"
    Then I should see the link "All content"
