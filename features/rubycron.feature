Feature: Parsing a cron expression
  In order to give anyone who doesn't have cron format 100% down cold
  a way to check that they've got the correct expression

  Scenario Outline: Parsing cron expressions
    When I parse the expression "<cron_expression>"
    Then I return "<human_readable>"

    Examples:
      | cron_expression       | human_readable                                                    |
      | sudo rm -r -f *       | Invalid Format                                                    |
      | *                     | Invalid Format                                                    |
      | * *                   | Invalid Format                                                    |
      | * * *                 | Invalid Format                                                    |
      | * * * *               | Invalid Format                                                    |
      | * * * * *             | Every minute                                                      |
      | * * * * * *           | Every minute                                                      |
      | 0 * * * *             | The beginning of every hour                                       |
      | 5 * * * *             | At the 5th minute of every hour                                   |
      | */2 * * * *           | Every 2 minutes                                                   |
      | 1/2 * * * *           | Every 2 minutes of every hour starting at xx:01                   |
      | 3-15/3 * * * *        | Every 3 minutes of every hour between xx:03 and xx:15             |
      | 4-26 * * * *          | Every minute of every hour between xx:04 and xx:26                |
      | 4,6,13-16 * * * *     | At the 4th, 6th, 13th, 14th, 15th and 16th minutes of every hour  |
      | * 4 * * *             | Every minute between 04:00 and 05:00                              |
      | */2 3 * * *           | Every 2 minutes between 03:00 and 04:00                           |
      | 3-15 3 * * *          | Every minute between 03:03 and 03:15                              |
      | 3-15/2 3 * * *        | Every 2 minutes between 03:03 and 03:15                           |
      | 1/2 3 * * *           | Every 2 minutes between 03:01 and 04:00                           |
      | 0 0 * * *             | At 00:00 every day                                                |
      | 15 7 * * *            | At 07:15 every day                                                |
      | * * 3 * *             | Every minute on the 3rd of every month                            |
      | 3 4 22 5 *            | At 04:03 on May 22nd                                              |
      | 30 18 30 JUN *        | At 18:30 on June 30th                                             |
      | 30 12 * MAY,JUN,AUG * | At 12:30 every day in May, June and August                        |
      | 30 12 * * 5           | At 12:30 every Friday                                             |
      | 30 12 * * mon,thu     | At 12:30 every Monday and Thursday                                |
      | * * 22 5 5            | Every minute on May 22nd if it is a Friday                        |
      | 0 8 3,6,9 MAR,JUN *   | At 08:00 on the 3rd, 6th and 9th of March and June                |
      | 59 23 31 12 0         | At 23:59 on December 31st if it is a Sunday                       |
