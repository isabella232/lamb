Feature: adding & processing jobs
  As a developer
  I want to add jobs
  So that they can complete later

Scenario: adding jobs
  Given a new queue "MyQueue"
  And a new job "Job1"
  And a new job "Job2"

  When job "Job1" is added to queue "MyQueue"
  And job "Job2" is added to queue "MyQueue"
  Then queue "MyQueue" should have 2 jobs

  When queue "MyQueue" is processed
  Then queue "MyQueue" should have 0 jobs
