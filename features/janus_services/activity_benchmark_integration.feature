Feature: Activity Benchmarks Display Study Activity Quantity via Unmocked Services

  Background:
    Given I am impersonating user "user1"
    And I should have study "350-Study-A" in the client division
    And I have design scenario "activity_analysis"
    And I have a scenario schedule (Schedule 1) within design scenario "activity_analysis"
    And I have study activities:
      | activity                            | activity_code |
      | Hemogram (CBC) w/ Plate & Auto Diff | 85025         |
      | Single Drug Level/PK; Any Source    | 80299         |
      | SMAC 19: 13+ Chemistries            | NC125         |
    And I have study events:
      | event   | encounter type   | visit type |
      | visit 1 | visit_outpatient | treatment  |
      | visit 2 | visit_outpatient | treatment  |
      | visit 3 | visit_outpatient | treatment  |
    And I visit study "350-Study-A" page

  @Release2015.2.0
  @PB159238-01
  @Validation
  Scenario: When I request to view activity summary benchmarks with no O/C selected on study event and with no O/C selected on study cell, I get the correct response
    And I visit the Schedule page
    And I click on "Schedule 1" schedule
    And I click on the 1st row 1st column cell of the "Schedule Grid" table
    Then I visit the Benchmark Analysis page
    And I should see exactly the following contents in the "Activity Benchmarks" table under "Study Activity Quantity" column header:
      | code  | Min  | Expected | Max  |
      | 85025 | 1.00 | 1.00     | 1.00 |

  @Release2015.2.0
  @PB159238-02
  @Validation
  Scenario: When I request to view activity summary benchmarks with O/C selected on study event and with no O/C selected on study cell, I get the correct response
    And I visit the Schedule page
    And I click on "Schedule 1" schedule
    And I click on the “Visit Optional/Conditional” menu on Visit 1
    Then I select “50” as the Percentage of Subjects and “Scheduled – Optional for Subject” as the "Optional/Conditional"
    And I click on the 1st row 1st column cell of the "Schedule Grid" table
    Then I visit the Benchmark Analysis page
    And I should see exactly the following contents in the "Activity Benchmarks" table under "Study Activity Quantity" column header:
      | code  | Min  | Expected | Max  |
      | 85025 | 0.00 | 0.50     | 1.00 |

  @Release2015.2.0
  @PB159238-03
  @Validation
  Scenario: When I request to view activity summary benchmarks with O/C selected on study cell and with no O/C selected on study event, I get the correct response
    And I visit the Schedule page
    And I click on "Schedule 1" schedule
    And I click on the “Quantity & Optional/Conditional” menu on the 1st row 1st column cell of the "Schedule Grid" table
    Then I select the following contents:
      | Required Minimum Quantity | Optional/Conditional     | Optional/Conditional Quantity | Percentage of Subjects |
      | 10                        | Specified Subject Gender | 30                            | 50                     |
    Then I visit the Benchmark Analysis page
    And I should see exactly the following contents in the "Activity Benchmarks" table under "Study Activity Quantity" column header:
      | code  | Min  | Expected | Max  |
      | 85025 | 10.00 | 25.00     | 40.00 |

  @Release2015.2.0
  @PB159238-04
  @Validation
  Scenario: When I request to view activity summary benchmarks with O/C selected on study event and with O/C selected on study cell, I get the correct response
    And I visit the Schedule page
    And I click on "Schedule 1" schedule
    And I click on the “Visit Optional/Conditional” menu on Visit 1
    Then I select “50” as the Percentage of Subjects and “Scheduled – Optional for Subject” as the "Optional/Conditional"
    And I click on the “Quantity & Optional/Conditional” menu on the 1st row 1st column cell of the "Schedule Grid" table
    Then I select the following contents:
      | Required Minimum Quantity | Optional/Conditional     | Optional/Conditional Quantity | Percentage of Subjects |
      | 10                        | Specified Subject Gender | 30                            | 50                     |
    Then I visit the Benchmark Analysis page
    And I should see exactly the following contents in the "Activity Benchmarks" table under "Study Activity Quantity" column header:
      | code  | Min  | Expected | Max  |
      | 85025 | 0.00 | 12.50     | 40.00 |

  @Release2015.2.0
  @PB159238-05
  @Validation
  Scenario: When I request to view activity summary benchmarks with multiple cells selected for the same activity, I get the correct response
    And I visit the Schedule page
    And I click on "Schedule 1" schedule
    And I click on the “Visit Optional/Conditional” menu on Visit 1
    Then I select “50” as the Percentage of Subjects and “Scheduled – Optional for Subject” as the "Optional/Conditional"
    And I click on the “Quantity & Optional/Conditional” menu on the 1st row 1st column cell of the "Schedule Grid" table
    Then I select the following contents:
      | Required Minimum Quantity | Optional/Conditional     | Optional/Conditional Quantity | Percentage of Subjects |
      | 10                        | Specified Subject Gender | 30                            | 50                     |
    And I click on the 1st row 2nd column cell of the "Schedule Grid" table
    Then I visit the Benchmark Analysis page
    And I should see exactly the following contents in the "Activity Benchmarks" table under "Study Activity Quantity" column header:
      | code  | Min  | Expected | Max  |
      | 85025 | 1.00 | 13.50     | 41.00 |
