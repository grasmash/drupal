Feature: Site Installation

  Scenario: Installation
    Given I am on "/core/install.php"
    Then I should see "Drupal already installed"
