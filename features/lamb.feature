Feature: adding & processing jobs
  As a developer
  I want to add jobs
  So that they can complete later

Scenario: the happy path with a single job
  Given everything is enabled
  When 1 job is added
  And I take a nap
  Then start has been called 1 time
  And check has been called 1 time
  And finish has been called 1 time

Scenario: the happy path with multiple jobs
  Given everything is enabled
  When 7 jobs are added
  And I take a nap
  Then start has been called 7 times
  And check has been called 7 times
  And finish has been called 7 times
