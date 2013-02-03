Feature: Parsing a cron expression
  In order to give anyone who doesn't have cron format 100% down cold
  a way to check that they've got the correct expression

  Scenario Outline: Parsing cron expressions
    When I parse the expression "<cron_expression>"
    Then I return "<human_readable>"

    Examples:
      | cron_expression             | human_readable                                                                                  |
      | * * * * *                   | Every minute every day                                                                          |
      | * * * * * *                 | Every minute every day                                                                          |
      | * 8-20/3 * * * *            | Every minute of every 3rd hour between 08:00 and 20:59 every day                                |
      | * 9-19 * * * *              | Every minute between 09:00 and 19:59 every day                                                  |
      | * */4 * * * *               | Every minute of every 4th hour every day                                                        |
      | * 5 * * * *                 | Every minute between 05:00 and 05:59 every day                                                  |
      | * 5,10,15 * * * *           | Every minute between 05:00 and 05:59, 10:00 and 10:59 and 15:00 and 15:59 every day             |
      | 0 * * * *                   | The beginning of every hour every day                                                           |
      | 8 * * * * *                 | The 8th minute of every hour every day                                                          |
      | 8 8-20/3 * * * *            | The 8th minute of every 3rd hour between 08:00 and 20:59 every day                              |
      | 8 9-19 * * * *              | The 8th minute of every hour between 09:00 and 19:59 every day                                  |
      | 8 */4 * * * *               | The 8th minute of every 4th hour every day                                                      |
      | 8 5 * * * *                 | 05:08 every day                                                                                 |
      | 8 5,10,15 * * * *           | 05:08, 10:08 and 15:08 every day                                                                |
      | 2,21,33,44 * * * * *        | The 2nd, 21st, 33rd and 44th minutes of every hour every day                                    |
      | 2,21,33,44 8-20/3 * * * *   | The 2nd, 21st, 33rd and 44th minutes of every 3rd hour between 08:00 and 20:59 every day        |
      | 2,21,33,44 9-19 * * * *     | The 2nd, 21st, 33rd and 44th minutes of every hour between 09:00 and 19:59 every day            |
      | 2,21,33,44 */4 * * * *      | The 2nd, 21st, 33rd and 44th minutes of every 4th hour every day                                |
      | 2,21,33,44 5 * * * *        | 05:02, 05:21, 05:33 and 05:44 every day                                                         |
      | 2,21,33,44 5,10,15 * * * *  | 05:02, 05:21, 05:33, 05:44, 10:02, 10:21, 10:33, 10:44, 15:02, 15:21, 15:33 and 15:44 every day |
      | */2 * * * * *               | Every 2 minutes every day                                                                       |
      | */2 8-20/3 * * * *          | Every 2 minutes of every 3rd hour between 08:00 and 20:59 every day                             |
      | */2 9-19 * * * *            | Every 2 minutes between 09:00 and 19:59 every day                                               |
      | */2 */4 * * * *             | Every 2 minutes of every 4th hour every day                                                     |
      | */2 5 * * * *               | Every 2 minutes between 05:00 and 05:59 every day                                               |
      | */2 5,10,15 * * * *         | Every 2 minutes between 05:00 and 05:59, 10:00 and 10:59 and 15:00 and 15:59 every day          |
      | 11-13 * * * * *             | Every hour from xx:11 to xx:13 every day                                                        |
      | 11-13 8-20/3 * * * *        | Every minute between xx:11 and xx:13 of every 3rd hour between 08:00 and 20:59 every day        |
      | 11-13 9-19 * * * *          | Every minute between xx:11 and xx:13 of every hour between 09:00 and 19:59 every day            |
      | 11-13 */4 * * * *           | Every minute between xx:11 and xx:13 of every 4th hour every day                                |
      | 11-13 5 * * * *             | Every minute between 05:11 and 05:13 every day                                                  |
      | 11-13 5,10,15 * * * *       | Every minute between 05:11 and 05:13, 10:11 and 10:13 and 15:11 and 15:13 every day             |
      | 10-18/2 * * * * *           | Every 2 minutes between xx:10 and xx:18 of every hour every day                                 |
      | 10-18/2 8-20/3 * * * *      | Every 2 minutes between xx:10 and xx:18 of every 3rd hour between 08:00 and 20:59 every day     |
      | 10-18/2 9-19 * * * *        | Every 2 minutes between xx:10 and xx:18 of every hour between 09:00 and 19:59 every day         |
      | 10-18/2 */4 * * * *         | Every 2 minutes between xx:10 and xx:18 of every 4th hour every day                             |
      | 10-18/2 5 * * * *           | Every 2 minutes between 05:10 and 05:18 every day                                               |
      | 10-18/2 5,10,15 * * * *     | Every 2 minutes between 05:10 and 05:18, 10:10 and 10:18 and 15:10 and 15:18 every day          |
