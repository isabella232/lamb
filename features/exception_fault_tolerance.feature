Feature: exception fault tolerance
  As a developer
  I want jobs to automatically retry after exceptions
  So I don't need to manually schedule them again

Background:
  Given the broker is started

Scenario: multiple exceptions
  Given 1 job is scheduled with 5/2/9 start/check/finish exceptions

  When the workers are started
  And I take a nap
  Then start/check/finish has been called 6/3/10 times
