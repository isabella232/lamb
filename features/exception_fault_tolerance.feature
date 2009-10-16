Feature: exception fault tolerance
  As a developer
  I want jobs to automatically retry after exceptions
  So I don't need to manually schedule them again

Background:
  Given the broker is started

Scenario: multiple exceptions
  Given 1 job is scheduled
  And 5 future start exceptions
  And 2 future check exceptions
  And 9 future finish exceptions

  When the workers are started
  And I take a nap
  Then start has been called 6 times
  And check has been called 3 times
  And finish has been called 10 times
