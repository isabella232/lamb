Feature: exception fault tolerance
  As a developer
  I want jobs to automatically retry after exceptions
  So I don't need to manually schedule them again

Background:
  Given the broker is started
  And the workers are started

Scenario: a single job with exceptions
  When 1 job is scheduled with 5/2/9 start/check/finish exceptions
  And I take a nap
  Then start/check/finish has been called 6/3/10 times

Scenario: multiple jobs with exceptions
  When 3 job is scheduled with 0/1/2 start/check/finish exceptions
  And I take a nap
  Then start/check/finish has been called 3/6/9 times
