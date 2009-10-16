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
  Then start/check/finish has been called 1/1/1 time

Scenario: multiple jobs
  When 7 jobs are scheduled
  And I take a nap
  Then start/check/finish has been called 7/7/7 times
