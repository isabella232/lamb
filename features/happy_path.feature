Feature: the happy path
  As a developer
  I want to add jobs
  So that they can eventually complete

Background:
  Given the broker is started
  And the workers are started

Scenario: a single job
  When 1 job is scheduled
  And I take a nap
  Then start has been called 1 time
  And check has been called 1 time
  And finish has been called 1 time

Scenario: multiple jobs
  When 7 jobs are scheduled
  And I take a nap
  Then start has been called 7 times
  And check has been called 7 times
  And finish has been called 7 times
