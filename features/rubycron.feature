Feature: Parsing a cron expression
  In order to give anyone who doesn't have cron format 100% down cold
  a way to check that they've got the correct expression

  Scenario Outline: Parsing cron expressions
    When I parse the expression "<cron_expression>"
    Then I return "<human_readable>"

    Examples:
      | cron_expression             | human_readable                                          |
      | sudo rm -r -f *             | Invalid Format                                          |
      | *                           | Invalid Format                                          |
      | * *                         | Invalid Format                                          |
      | * * *                       | Invalid Format                                          |
      | * * * *                     | Invalid Format                                          |
      | 3 4 22 5 * *                | 04:03 on May 22nd                                       |
      | 3 4 22 5 * 1985             | 04:03 on May 22nd, 1985                                 |
      | 3 4 22 5 * 1985,1989        | 04:03 on May 22nd in 1985 and 1989                      |
      | 3 4 22 5 * 1990-2000/2      | 04:03 on May 22nd every 2 years between 1990 and 2000   |
      | 3 4 22 5 * 2013/3           | 04:03 on May 22nd every 3 years starting in 2013        |
      | 3 4 22 5 * */4              | 04:03 on May 22nd every 4 years                         |
      | 3 4 22 5 * 1985-2000        | 04:03 on May 22nd every year between 1985 and 2000      |
