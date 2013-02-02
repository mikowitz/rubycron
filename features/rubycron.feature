Feature: Parsing a cron expression
  In order to give anyone who doesn't have cron format 100% down cold
  a way to check that they've got the correct expression

  Scenario Outline: Parsing cron expressions
    When I parse the expression "<cron_expression>"
    Then I return "<human_readable>"

    Examples:
      | cron_expression             | human_readable                                                                                  |
      | sudo rm -r -f *             | Invalid Format                                                                                  |
      | *                           | Invalid Format                                                                                  |
      | * *                         | Invalid Format                                                                                  |
      | * * *                       | Invalid Format                                                                                  |
      | * * * *                     | Invalid Format                                                                                  |
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
      | */2 * * * * *               | Every 2 minutes every day                                                                      |
      | */2 8-20/3 * * * *          | Every 2 minutes of every 3rd hour between 08:00 and 20:59 every day                            |
      | */2 9-19 * * * *            | Every 2 minutes of every hour between 09:00 and 19:59 every day                                | 
      | */2 */4 * * * *             | Every 2 minutes of every 4th hour every day                                                    |
      | */2 5 * * * *               | Every 2 minutes between 05:00 and 05:59 every day                                              |
      | */2 5,10,15 * * * *         | Every 2 minutes between 05:00 and 05:59, 10:00 and 10:59 and 15:00 and 15:59 every day         |
      | 11-13 * * * * *             | Every hour between xx:11 and xx:13 every day|
      | 11-13 8-20/3 * * * *        | Every minute between xx:11 and xx:13 every 3rd hour between 08:00 and 20:59 every day|
      | 11-13 9-19 * * * *          | Every minute between xx:11 and xx:13 every hour between 09:00 and 19:59 every day|
      | 11-13 */4 * * * *           | Between xx:11 and xx:13 every 4th hour every day|
      | 11-13 5 * * * *             | Every minute between 05:11 and 05:13 every day|
      | 11-13 5,10,15 * * * *       | Every minute between 05:11 and 05:13, 10:11 and 10:13 and 15:11 and 15:13 every day|
      | 10-18/2 * * * * *           | Every 2 minutes between xx:10 and xx:18 every hour every day|
      | 10-18/2 8-20/3 * * * *      | Every 2 minutes between xx:10 and xx:18 every 3rd hour between 08:00 and 20:59 every day|
      | 10-18/2 9-19 * * * *        | Every 2 minutes between xx:10 and xx:18 every hour between 09:00 and 19:59 every day|
      | 10-18/2 */4 * * * *         | Every 2 minutes between xx:10 and xx:18 every 4th hour every day|
      | 10-18/2 5 * * * *           | Every 2 minutes between 05:10 and 05:18 every day|
      | 10-18/2 5,10,15 * * * *     | Every 2 minutes between 05:10 and 05:18, 10:10 and 10:18 and 15:10 and 15:18 every day|
      #| 5 * * * *             | The 5th minute of every hour every day                                      |
      #| */2 * * * *           | Every 2 minutes every day                                                   |
      #| 5/2 * * * *           | Every 2 minutes of every hour starting at xx:05 every day                   |
      #| 3-15/3 * * * *        | Every 3 minutes of every hour between xx:03 and xx:15 every day             |
      #| 4-26 * * * *          | Every minute of every hour between xx:04 and xx:26 every day                |
      #| 4,6,13-16 * * * *     | The 4th, 6th, 13th, 14th, 15th and 16th minutes of every hour every day     |
      #| * 4 * * *             | Every minute between 04:00 and 04:59 every day                             |
      #| */2 3 * * *           | Every 2 minutes between 03:00 and 04:00 every day                           |
      #| 3-15 3 * * *          | Every minute between 03:03 and 03:15 every day                              |
      #| 3-15/2 3 * * *        | Every 2 minutes between 03:03 and 03:15 every day                           |
      #| 1/2 3 * * *           | Every 2 minutes between 03:01 and 04:00 every day                           |
      | 0 0 * * *             | 00:00 every day                                                   |
      | 15 7 * * *            | 07:15 every day                                                   |
      | * * 3 * *             | Every minute on the 3rd of every month                            |
      | 3 4 22 5 *            | 04:03 on May 22nd                                                 |
      | 30 18 30 JUN *        | 18:30 on June 30th                                                |
      | 30 12 * MAY,JUN,AUG * | 12:30 every day in May, June and August                           |
      | 30 12 * * 5           | 12:30 every Friday                                                |
      | 30 12 * * mon,thu     | 12:30 every Monday and Thursday                                   |
      | * * 22 5 5            | Every minute on May 22nd if it is a Friday                        |
      | 0 8 3,6,9 MAR,JUN *   | 08:00 on the 3rd, 6th and 9th of March and June                   |
      | 59 23 31 12 0         | 23:59 on December 31st if it is a Sunday                          |
