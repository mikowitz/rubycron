Feature: Parsing a cron expression with dates
  In order to give anyone who doesn't have cron format 100% down cold
  a way to check that they've got the correct expression

  Scenario Outline: Parsing cron expressions
    When I parse the expression "<cron_expression>"
    Then I return "<human_readable>"

    Examples:
      | cron_expression                  | human_readable                                                                                                                               |
      | * * 3-20/3 * * *                 | Every minute on every 3rd day from the 3rd to the 20th of every month                                                                        |
      | * * 1-15 * * *                   | Every minute on the 1st to the 15th of every month                                                                                           |
      | * * */5 * * *                    | Every minute on every 5th day of every month                                                                                                 |
      | * * 2/5 * * *                    | Every minute on every 5th day starting on the 2nd of every month                                                                             |
      | * * 22 * * *                     | Every minute on the 22nd of every month                                                                                                      |
      | * * 4,5,7 * * *                  | Every minute on the 4th, 5th and 7th of every month                                                                                          |
      | * * L * * *                      | Every minute on the last day of every month                                                                                                  |
      | * * 17W * * *                    | Every minute on the weekday closest to the 17th of every month                                                                               |
      | * * * 1-11/2 * *                 | Every minute on every day of every 2nd month from January to November                                                                        |
      | * * 3-20/3 1-11/2 * *            | Every minute on every 3rd day from the 3rd to the 20th of every 2nd month from January to November                                           |
      | * * 1-15 1-11/2 * *              | Every minute on the 1st to the 15th of every 2nd month from January to November                                                              |
      | * * */5 1-11/2 * *               | Every minute on every 5th day of every 2nd month from January to November                                                                    |
      | * * 2/5 1-11/2 * *               | Every minute on every 5th day starting on the 2nd of every 2nd month from January to November                                                |
      | * * 22 1-11/2 * *                | Every minute on the 22nd of every 2nd month from January to November                                                                         |
      | * * 4,5,7 1-11/2 * *             | Every minute on the 4th, 5th and 7th of every 2nd month from January to November                                                             |
      | * * L 1-11/2 * *                 | Every minute on the last day of every 2nd month from January to November                                                                     |
      | * * 17W 1-11/2 * *               | Every minute on the weekday closest to the 17th of every 2nd month from January to November                                                  |
      | * * * 3-7 * *                    | Every minute on every day of every month from March to July                                                                                  |
      | * * 3-20/3 3-7 * *               | Every minute on every 3rd day from the 3rd to the 20th of every month from March to July                                                     |
      | * * 1-15 3-7 * *                 | Every minute on the 1st to the 15th of every month from March to July                                                                        |
      | * * */5 3-7 * *                  | Every minute on every 5th day of every month from March to July                                                                              |
      | * * 2/5 3-7 * *                  | Every minute on every 5th day starting on the 2nd of every month from March to July                                                          |
      | * * 22 3-7 * *                   | Every minute on the 22nd of every month from March to July                                                                                   |
      | * * 4,5,7 3-7 * *                | Every minute on the 4th, 5th and 7th of every month from March to July                                                                       |
      | * * L 3-7 * *                    | Every minute on the last day of every month from March to July                                                                               |
      | * * 17W 3-7 * *                  | Every minute on the weekday closest to the 17th of every month from March to July                                                            |
      | * * * */4 * *                    | Every minute on every day of every 4th month                                                                                                 |
      | * * 3-20/3 */4 * *               | Every minute on every 3rd day from the 3rd to the 20th of every 4th month                                                                    |
      | * * 1-15 */4 * *                 | Every minute on the 1st to the 15th of every 4th month                                                                                       |
      | * * */5 */4 * *                  | Every minute on every 5th day of every 4th month                                                                                             |
      | * * 2/5 */4 * *                  | Every minute on every 5th day starting on the 2nd of every 4th month                                                                         |
      | * * 22 */4 * *                   | Every minute on the 22nd of every 4th month                                                                                                  |
      | * * 4,5,7 */4 * *                | Every minute on the 4th, 5th and 7th of every 4th month                                                                                      |
      | * * L */4 * *                    | Every minute on the last day of every 4th month                                                                                              |
      | * * 17W */4 * *                  | Every minute on the weekday closest to the 17th of every 4th month                                                                           |
      | * * * 2/5 * *                    | Every minute on every day of every 5th month from February to December                                                                       |
      | * * 3-20/3 2/5 * *               | Every minute on every 3rd day from the 3rd to the 20th of every 5th month from February to December                                          |
      | * * 1-15 2/5 * *                 | Every minute on the 1st to the 15th of every 5th month from February to December                                                             |
      | * * */5 2/5 * *                  | Every minute on every 5th day of every 5th month from February to December                                                                   |
      | * * 2/5 2/5 * *                  | Every minute on every 5th day starting on the 2nd of every 5th month from February to December                                               |
      | * * 22 2/5 * *                   | Every minute on the 22nd of every 5th month from February to December                                                                        |
      | * * 4,5,7 2/5 * *                | Every minute on the 4th, 5th and 7th of every 5th month from February to December                                                            |
      | * * L 2/5 * *                    | Every minute on the last day of every 5th month from February to December                                                                    |
      | * * 17W 2/5 * *                  | Every minute on the weekday closest to the 17th of every 5th month from February to December                                                 |
      | * * * 5 * *                      | Every minute on every day of May                                                                                                             |
      | * * 3-20/3 5 * *                 | Every minute on every 3rd day from the 3rd to the 20th of May                                                                                |
      | * * 1-15 5 * *                   | Every minute on the 1st to the 15th of May                                                                                                   |
      | * * */5 5 * *                    | Every minute on every 5th day of May                                                                                                         |
      | * * 2/5 5 * *                    | Every minute on every 5th day of May starting on the 2nd                                                                                     |
      | * * 22 5 * *                     | Every minute on May 22nd                                                                                                                     |
      | * * 4,5,7 5 * *                  | Every minute on May 4th, 5th and 7th                                                                                                         |
      | * * L 5 * *                      | Every minute on the last day of May                                                                                                          |
      | * * 17W 5 * *                    | Every minute on the weekday closest to May 17th                                                                                              |
      | * * * APR,AUG * *                | Every minute on every day of April and August                                                                                                |
      | * * 3-20/3 apr,aug * *           | Every minute on every 3rd day from the 3rd to the 20th of April and August                                                                   |
      | * * 1-15 APR,AUG * *             | Every minute on the 1st to the 15th of April and August                                                                                      |
      | * * */5 apr,aug * *              | Every minute on every 5th day of April and August                                                                                            |
      | * * 2/5 apr,aug * *              | Every minute on every 5th day of April and August starting on the 2nd                                                                        |
      | * * 22 APR,AUG * *               | Every minute on the 22nd of April and August                                                                                                 |
      | * * 4,5,7 apr,aug * *            | Every minute on the 4th, 5th and 7th of April and August                                                                                     |
      | * * L APR,AUG * *                | Every minute on the last day of April and August                                                                                             |
      | * * 17W APR,AUG * *              | Every minute on the weekdays closest to April and August 17th                                                                                |
      | * * * * 1 *                      | Every minute on every Monday of every month                                                                                                  |
      | * * 3-20/3 * 1 *                 | Every minute on every 3rd day from the 3rd to the 20th and every Monday of every month                                                       |
      | * * 1-15 * 1 *                   | Every minute on the 1st to the 15th and every Monday of every month                                                                          |
      | * * */5 * 1 *                    | Every minute on every 5th day and every Monday of every month                                                                                |
      | * * 2/5 * 1 *                    | Every minute on every 5th day starting on the 2nd and every Monday of every month                                                                                |
      | * * 22 * 1 *                     | Every minute on the 22nd and every Monday of every month                                                                                     |
      | * * 4,5,7 * 1 *                  | Every minute on the 4th, 5th and 7th and every Monday of every month                                                                         |
      | * * L * 1 *                      | Every minute on the last day and every Monday of every month                                                                                 |
      | * * 17W * 1 *                    | Every minute on the weekday closest to the 17th and every Monday of every month                                                              |
      | * * * 1-11/2 1 *                 | Every minute on every Monday of every 2nd month from January to November                                                                     |
      | * * 3-20/3 1-11/2 1 *            | Every minute on every 3rd day from the 3rd to the 20th and every Monday of every 2nd month from January to November                          |
      | * * 1-15 1-11/2 1 *              | Every minute on the 1st to the 15th and every Monday of every 2nd month from January to November                                             |
      | * * */5 1-11/2 1 *               | Every minute on every 5th day and every Monday of every 2nd month from January to November                                                   |
      | * * 2/5 1-11/2 1 *               | Every minute on every 5th day starting on the 2nd and every Monday of every 2nd month from January to November                                                   |
      | * * 22 1-11/2 1 *                | Every minute on the 22nd and every Monday of every 2nd month from January to November                                                        |
      | * * 4,5,7 1-11/2 1 *             | Every minute on the 4th, 5th and 7th and every Monday of every 2nd month from January to November                                            |
      | * * L 1-11/2 1 *                 | Every minute on the last day and every Monday of every 2nd month from January to November                                                    |
      | * * 17W 1-11/2 1 *               | Every minute on the weekday closest to the 17th and every Monday of every 2nd month from January to November                                 |
      | * * * 5 1 *                      | Every minute on every Monday of May                                                                                                          |
      | * * 3-20/3 5 1 *                 | Every minute on every 3rd day from the 3rd to the 20th and every Monday of May                                                               |
      | * * 1-15 5 1 *                   | Every minute on the 1st to the 15th and every Monday of May                                                                                  |
      | * * */5 5 1 *                    | Every minute on every 5th day and every Monday of May                                                                                        |
      | * * 2/5 5 1 *                    | Every minute on every 5th day starting on the 2nd and every Monday of May                                                                                        |
      | * * 22 5 1 *                     | Every minute on May 22nd and every Monday in May                                                                                             |
      | * * 4,5,7 5 1 *                  | Every minute on May 4th, 5th and 7th and every Monday in May                                                                                 |
      | * * L 5 1 *                      | Every minute on the last day and every Monday of May                                                                                         |
      | * * 17W 5 1 *                    | Every minute on the weekday closest to May 17th and every Monday in May                                                                      |
      | * * * APR,AUG 1 *                | Every minute on every Monday of April and August                                                                                             |
      | * * 3-20/3 apr,aug 1 *           | Every minute on every 3rd day from the 3rd to the 20th and every Monday of April and August                                                  |
      | * * 1-15 APR,AUG 1 *             | Every minute on the 1st to the 15th and every Monday of April and August                                                                     |
      | * * */5 apr,aug 1 *              | Every minute on every 5th day and every Monday of April and August                                                                           |
      | * * 2/5 apr,aug 1 *              | Every minute on every 5th day starting on the 2nd and every Monday of April and August                                                                           |
      | * * 22 APR,AUG 1 *               | Every minute on the 22nd and every Monday of April and August                                                                                |
      | * * 4,5,7 apr,aug 1 *            | Every minute on the 4th, 5th and 7th and every Monday of April and August                                                                    |
      | * * L APR,AUG 1 *                | Every minute on the last day and every Monday of April and August                                                                            |
      | * * 17W APR,AUG 1 *              | Every minute on the weekdays closest to April and August 17th and every Monday in April and August                                           |
      | * * * * 2-4 *                    | Every minute on every Tuesday, Wednesday and Thursday of every month                                                                         |
      | * * 3-20/3 * 2-4 *               | Every minute on every 3rd day from the 3rd to the 20th and every Tuesday, Wednesday and Thursday of every month                              |
      | * * 1-15 * 2-4 *                 | Every minute on the 1st to the 15th and every Tuesday, Wednesday and Thursday of every month                                                 |
      | * * */5 * 2-4 *                  | Every minute on every 5th day and every Tuesday, Wednesday and Thursday of every month                                                       |
      | * * 2/5 * 2-4 *                  | Every minute on every 5th day starting on the 2nd and every Tuesday, Wednesday and Thursday of every month                                                       |
      | * * 22 * 2-4 *                   | Every minute on the 22nd and every Tuesday, Wednesday and Thursday of every month                                                            |
      | * * 4,5,7 * 2-4 *                | Every minute on the 4th, 5th and 7th and every Tuesday, Wednesday and Thursday of every month                                                |
      | * * L * 2-4 *                    | Every minute on the last day and every Tuesday, Wednesday and Thursday of every month                                                        |
      | * * 17W * 2-4 *                  | Every minute on the weekday closest to the 17th and every Tuesday, Wednesday and Thursday of every month                                     |
      | * * * 1-11/2 2-4 *               | Every minute on every Tuesday, Wednesday and Thursday of every 2nd month from January to November                                            |
      | * * 3-20/3 1-11/2 2-4 *          | Every minute on every 3rd day from the 3rd to the 20th and every Tuesday, Wednesday and Thursday of every 2nd month from January to November |
      | * * 1-15 1-11/2 2-4 *            | Every minute on the 1st to the 15th and every Tuesday, Wednesday and Thursday of every 2nd month from January to November                    |
      | * * */5 1-11/2 2-4 *             | Every minute on every 5th day and every Tuesday, Wednesday and Thursday of every 2nd month from January to November                          |
      | * * 2/5 1-11/2 2-4 *             | Every minute on every 5th day starting on the 2nd and every Tuesday, Wednesday and Thursday of every 2nd month from January to November                          |
      | * * 22 1-11/2 2-4 *              | Every minute on the 22nd and every Tuesday, Wednesday and Thursday of every 2nd month from January to November                               |
      | * * 4,5,7 1-11/2 2-4 *           | Every minute on the 4th, 5th and 7th and every Tuesday, Wednesday and Thursday of every 2nd month from January to November                   |
      | * * L 1-11/2 2-4 *               | Every minute on the last day and every Tuesday, Wednesday and Thursday of every 2nd month from January to November                           |
      | * * 17W 1-11/2 2-4 *             | Every minute on the weekday closest to the 17th and every Tuesday, Wednesday and Thursday of every 2nd month from January to November        |
      | * * * 5 2-4 *                    | Every minute on every Tuesday, Wednesday and Thursday of May                                                                                 |
      | * * 3-20/3 5 2-4 *               | Every minute on every 3rd day from the 3rd to the 20th and every Tuesday, Wednesday and Thursday of May                                      |
      | * * 1-15 5 2-4 *                 | Every minute on the 1st to the 15th and every Tuesday, Wednesday and Thursday of May                                                         |
      | * * */5 5 2-4 *                  | Every minute on every 5th day and every Tuesday, Wednesday and Thursday of May                                                               |
      | * * 2/5 5 2-4 *                  | Every minute on every 5th day starting on the 2nd and every Tuesday, Wednesday and Thursday of May                                                               |
      | * * 22 5 2-4 *                   | Every minute on May 22nd and every Tuesday, Wednesday and Thursday in May                                                                    |
      | * * 4,5,7 5 2-4 *                | Every minute on May 4th, 5th and 7th and every Tuesday, Wednesday and Thursday in May                                                        |
      | * * L 5 2-4 *                    | Every minute on the last day and every Tuesday, Wednesday and Thursday of May                                                                |
      | * * 17W 5 2-4 *                  | Every minute on the weekday closest to May 17th and every Tuesday, Wednesday and Thursday in May                                             |
      | * * * APR,AUG 2-4 *              | Every minute on every Tuesday, Wednesday and Thursday of April and August                                                                    |
      | * * 3-20/3 apr,aug 2-4 *         | Every minute on every 3rd day from the 3rd to the 20th and every Tuesday, Wednesday and Thursday of April and August                         |
      | * * 1-15 APR,AUG 2-4 *           | Every minute on the 1st to the 15th and every Tuesday, Wednesday and Thursday of April and August                                            |
      | * * */5 apr,aug 2-4 *            | Every minute on every 5th day and every Tuesday, Wednesday and Thursday of April and August                                                  |
      | * * 2/5 apr,aug 2-4 *            | Every minute on every 5th day starting on the 2nd and every Tuesday, Wednesday and Thursday of April and August                                                  |
      | * * 22 APR,AUG 2-4 *             | Every minute on the 22nd and every Tuesday, Wednesday and Thursday of April and August                                                       |
      | * * 4,5,7 apr,aug 2-4 *          | Every minute on the 4th, 5th and 7th and every Tuesday, Wednesday and Thursday of April and August                                           |
      | * * L APR,AUG 2-4 *              | Every minute on the last day and every Tuesday, Wednesday and Thursday of April and August                                                   |
      | * * 17W APR,AUG 2-4 *            | Every minute on the weekdays closest to April and August 17th and every Tuesday, Wednesday and Thursday in April and August                  |
      | * * * * mon,wed,fri *            | Every minute on every Monday, Wednesday and Friday of every month                                                                            |
      | * * 3-20/3 * MON,WED,FRI *       | Every minute on every 3rd day from the 3rd to the 20th and every Monday, Wednesday and Friday of every month                                 |
      | * * 1-15 * MON,WED,FRI *         | Every minute on the 1st to the 15th and every Monday, Wednesday and Friday of every month                                                    |
      | * * */5 * MON,WED,FRI *          | Every minute on every 5th day and every Monday, Wednesday and Friday of every month                                                          |
      | * * 2/5 * MON,WED,FRI *          | Every minute on every 5th day starting on the 2nd and every Monday, Wednesday and Friday of every month                                                          |
      | * * 22 * MON,WED,FRI *           | Every minute on the 22nd and every Monday, Wednesday and Friday of every month                                                               |
      | * * 4,5,7 * MON,WED,FRI *        | Every minute on the 4th, 5th and 7th and every Monday, Wednesday and Friday of every month                                                   |
      | * * L * MON,WED,FRI *            | Every minute on the last day and every Monday, Wednesday and Friday of every month                                                           |
      | * * 17W * MON,WED,FRI *          | Every minute on the weekday closest to the 17th and every Monday, Wednesday and Friday of every month                                        |
      | * * * 1-11/2 MON,WED,FRI *       | Every minute on every Monday, Wednesday and Friday of every 2nd month from January to November                                               |
      | * * 3-20/3 1-11/2 MON,WED,FRI *  | Every minute on every 3rd day from the 3rd to the 20th and every Monday, Wednesday and Friday of every 2nd month from January to November    |
      | * * 1-15 1-11/2 MON,WED,FRI *    | Every minute on the 1st to the 15th and every Monday, Wednesday and Friday of every 2nd month from January to November                       |
      | * * */5 1-11/2 MON,WED,FRI *     | Every minute on every 5th day and every Monday, Wednesday and Friday of every 2nd month from January to November                             |
      | * * 2/5 1-11/2 MON,WED,FRI *     | Every minute on every 5th day starting on the 2nd and every Monday, Wednesday and Friday of every 2nd month from January to November                             |
      | * * 22 1-11/2 MON,WED,FRI *      | Every minute on the 22nd and every Monday, Wednesday and Friday of every 2nd month from January to November                                  |
      | * * 4,5,7 1-11/2 MON,WED,FRI *   | Every minute on the 4th, 5th and 7th and every Monday, Wednesday and Friday of every 2nd month from January to November                      |
      | * * L 1-11/2 MON,WED,FRI *       | Every minute on the last day and every Monday, Wednesday and Friday of every 2nd month from January to November                              |
      | * * 17W 1-11/2 MON,WED,FRI *     | Every minute on the weekday closest to the 17th and every Monday, Wednesday and Friday of every 2nd month from January to November           |
      | * * * 5 MON,WED,FRI *            | Every minute on every Monday, Wednesday and Friday of May                                                                                    |
      | * * 3-20/3 5 MON,WED,FRI *       | Every minute on every 3rd day from the 3rd to the 20th and every Monday, Wednesday and Friday of May                                         |
      | * * 1-15 5 MON,WED,FRI *         | Every minute on the 1st to the 15th and every Monday, Wednesday and Friday of May                                                            |
      | * * 2/5 5 MON,WED,FRI *          | Every minute on every 5th day starting on the 2nd and every Monday, Wednesday and Friday of May                                                                  |
      | * * 22 5 MON,WED,FRI *           | Every minute on May 22nd and every Monday, Wednesday and Friday in May                                                                       |
      | * * 4,5,7 5 MON,WED,FRI *        | Every minute on May 4th, 5th and 7th and every Monday, Wednesday and Friday in May                                                           |
      | * * L 5 MON,WED,FRI *            | Every minute on the last day and every Monday, Wednesday and Friday of May                                                                   |
      | * * 17W 5 MON,WED,FRI *          | Every minute on the weekday closest to May 17th and every Monday, Wednesday and Friday in May                                                |
      | * * * APR,AUG MON,WED,FRI *      | Every minute on every Monday, Wednesday and Friday of April and August                                                                       |
      | * * 3-20/3 apr,aug MON,WED,FRI * | Every minute on every 3rd day from the 3rd to the 20th and every Monday, Wednesday and Friday of April and August                            |
      | * * 1-15 APR,AUG MON,WED,FRI *   | Every minute on the 1st to the 15th and every Monday, Wednesday and Friday of April and August                                               |
      | * * */5 apr,aug MON,WED,FRI *    | Every minute on every 5th day and every Monday, Wednesday and Friday of April and August                                                     |
      | * * 2/5 apr,aug MON,WED,FRI *    | Every minute on every 5th day starting on the 2nd and every Monday, Wednesday and Friday of April and August                                                     |
      | * * 22 APR,AUG MON,WED,FRI *     | Every minute on the 22nd and every Monday, Wednesday and Friday of April and August                                                          |
      | * * 4,5,7 apr,aug MON,WED,FRI *  | Every minute on the 4th, 5th and 7th and every Monday, Wednesday and Friday of April and August                                              |
      | * * L APR,AUG MON,WED,FRI *      | Every minute on the last day and every Monday, Wednesday and Friday of April and August                                                      |
      | * * 17W APR,AUG MON,WED,FRI *    | Every minute on the weekdays closest to April and August 17th and every Monday, Wednesday and Friday in April and August                     |
      | * * * * 6l *                     | Every minute on the last Saturday of every month                                                                                             |
      | * * 3-20/3 * 6L *                | Every minute on every 3rd day from the 3rd to the 20th and the last Saturday of every month                                                  |
      | * * 1-15 * 6L *                  | Every minute on the 1st to the 15th and the last Saturday of every month                                                                     |
      | * * */5 * 6L *                   | Every minute on every 5th day and the last Saturday of every month                                                                           |
      | * * 2/5 * 6L *                   | Every minute on every 5th day starting on the 2nd and the last Saturday of every month                                                                           |
      | * * 22 * 6L *                    | Every minute on the 22nd and the last Saturday of every month                                                                                |
      | * * 4,5,7 * 6L *                 | Every minute on the 4th, 5th and 7th and the last Saturday of every month                                                                    |
      | * * L * 6L *                     | Every minute on the last day and the last Saturday of every month                                                                            |
      | * * 17W * 6L *                   | Every minute on the weekday closest to the 17th and the last Saturday of every month                                                         |
      | * * * 1-11/2 6L *                | Every minute on the last Saturday of every 2nd month from January to November                                                                |
      | * * 3-20/3 1-11/2 6L *           | Every minute on every 3rd day from the 3rd to the 20th and the last Saturday of every 2nd month from January to November                     |
      | * * 1-15 1-11/2 6L *             | Every minute on the 1st to the 15th and the last Saturday of every 2nd month from January to November                                        |
      | * * */5 1-11/2 6L *              | Every minute on every 5th day and the last Saturday of every 2nd month from January to November                                              |
      | * * 2/5 1-11/2 6L *              | Every minute on every 5th day starting on the 2nd and the last Saturday of every 2nd month from January to November                                              |
      | * * 22 1-11/2 6L *               | Every minute on the 22nd and the last Saturday of every 2nd month from January to November                                                   |
      | * * 4,5,7 1-11/2 6L *            | Every minute on the 4th, 5th and 7th and the last Saturday of every 2nd month from January to November                                       |
      | * * L 1-11/2 6L *                | Every minute on the last day and the last Saturday of every 2nd month from January to November                                               |
      | * * 17W 1-11/2 6L *              | Every minute on the weekday closest to the 17th and the last Saturday of every 2nd month from January to November                            |
      | * * * 5 6L *                     | Every minute on the last Saturday of May                                                                                                     |
      | * * 3-20/3 5 6L *                | Every minute on every 3rd day from the 3rd to the 20th and the last Saturday of May                                                          |
      | * * 1-15 5 6L *                  | Every minute on the 1st to the 15th and the last Saturday of May                                                                             |
      | * * */5 5 6L *                   | Every minute on every 5th day and the last Saturday of May                                                                                   |
      | * * 2/5 5 6L *                   | Every minute on every 5th day starting on the 2nd and the last Saturday of May                                                                                   |
      | * * 22 5 6L *                    | Every minute on May 22nd and the last Saturday in May                                                                                        |
      | * * 4,5,7 5 6L *                 | Every minute on May 4th, 5th and 7th and the last Saturday in May                                                                            |
      | * * L 5 6L *                     | Every minute on the last day and the last Saturday of May                                                                                    |
      | * * 17W 5 6L *                   | Every minute on the weekday closest to May 17th and the last Saturday in May                                                                 |
      | * * * APR,AUG 6L *               | Every minute on the last Saturday of April and August                                                                                        |
      | * * 3-20/3 apr,aug 6L *          | Every minute on every 3rd day from the 3rd to the 20th and the last Saturday of April and August                                             |
      | * * 1-15 APR,AUG 6L *            | Every minute on the 1st to the 15th and the last Saturday of April and August                                                                |
      | * * */5 apr,aug 6L *             | Every minute on every 5th day and the last Saturday of April and August                                                                      |
      | * * 2/5 apr,aug 6L *             | Every minute on every 5th day starting on the 2nd and the last Saturday of April and August                                                                      |
      | * * 22 APR,AUG 6L *              | Every minute on the 22nd and the last Saturday of April and August                                                                           |
      | * * 4,5,7 apr,aug 6L *           | Every minute on the 4th, 5th and 7th and the last Saturday of April and August                                                               |
      | * * L APR,AUG satL *             | Every minute on the last day and the last Saturday of April and August                                                                       |
      | * * 17W APR,AUG SATL *           | Every minute on the weekdays closest to April and August 17th and the last Saturday in April and August                                      |
      | * * * * THU#4 *                  | Every minute on the 4th Thursday of every month                                                                                              |
      | * * 3-20/3 * THU#4 *             | Every minute on every 3rd day from the 3rd to the 20th and the 4th Thursday of every month                                                   |
      | * * 1-15 * THU#4 *               | Every minute on the 1st to the 15th and the 4th Thursday of every month                                                                      |
      | * * */5 * THU#4 *                | Every minute on every 5th day and the 4th Thursday of every month                                                                            |
      | * * 2/5 * THU#4 *                | Every minute on every 5th day starting on the 2nd and the 4th Thursday of every month                                                                            |
      | * * 22 * THU#4 *                 | Every minute on the 22nd and the 4th Thursday of every month                                                                                 |
      | * * 4,5,7 * THU#4 *              | Every minute on the 4th, 5th and 7th and the 4th Thursday of every month                                                                     |
      | * * L * THU#4 *                  | Every minute on the last day and the 4th Thursday of every month                                                                             |
      | * * 17W * THU#4 *                | Every minute on the weekday closest to the 17th and the 4th Thursday of every month                                                          |
      | * * * 1-11/2 THU#4 *             | Every minute on the 4th Thursday of every 2nd month from January to November                                                                 |
      | * * 3-20/3 1-11/2 THU#4 *        | Every minute on every 3rd day from the 3rd to the 20th and the 4th Thursday of every 2nd month from January to November                      |
      | * * 1-15 1-11/2 THU#4 *          | Every minute on the 1st to the 15th and the 4th Thursday of every 2nd month from January to November                                         |
      | * * */5 1-11/2 THU#4 *           | Every minute on every 5th day and the 4th Thursday of every 2nd month from January to November                                               |
      | * * 2/5 1-11/2 THU#4 *           | Every minute on every 5th day starting on the 2nd and the 4th Thursday of every 2nd month from January to November                                               |
      | * * 22 1-11/2 THU#4 *            | Every minute on the 22nd and the 4th Thursday of every 2nd month from January to November                                                    |
      | * * 4,5,7 1-11/2 THU#4 *         | Every minute on the 4th, 5th and 7th and the 4th Thursday of every 2nd month from January to November                                        |
      | * * L 1-11/2 THU#4 *             | Every minute on the last day and the 4th Thursday of every 2nd month from January to November                                                |
      | * * 17W 1-11/2 THU#4 *           | Every minute on the weekday closest to the 17th and the 4th Thursday of every 2nd month from January to November                             |
      | * * * 5 THU#4 *                  | Every minute on the 4th Thursday of May                                                                                                      |
      | * * 3-20/3 5 THU#4 *             | Every minute on every 3rd day from the 3rd to the 20th and the 4th Thursday of May                                                           |
      | * * 1-15 5 THU#4 *               | Every minute on the 1st to the 15th and the 4th Thursday of May                                                                              |
      | * * */5 5 THU#4 *                | Every minute on every 5th day and the 4th Thursday of May                                                                                    |
      | * * 2/5 5 THU#4 *                | Every minute on every 5th day starting on the 2nd and the 4th Thursday of May                                                                                    |
      | * * 22 5 THU#4 *                 | Every minute on May 22nd and the 4th Thursday in May                                                                                         |
      | * * 4,5,7 5 THU#4 *              | Every minute on May 4th, 5th and 7th and the 4th Thursday in May                                                                             |
      | * * L 5 THU#4 *                  | Every minute on the last day and the 4th Thursday of May                                                                                     |
      | * * 17W 5 THU#4 *                | Every minute on the weekday closest to May 17th and the 4th Thursday in May                                                                  |
      | * * * APR,AUG THU#4 *            | Every minute on the 4th Thursday of April and August                                                                                         |
      | * * 3-20/3 apr,aug THU#4 *       | Every minute on every 3rd day from the 3rd to the 20th and the 4th Thursday of April and August                                              |
      | * * 1-15 APR,AUG THU#4 *         | Every minute on the 1st to the 15th and the 4th Thursday of April and August                                                                 |
      | * * */5 apr,aug THU#4 *          | Every minute on every 5th day and the 4th Thursday of April and August                                                                       |
      | * * 2/5 apr,aug THU#4 *          | Every minute on every 5th day starting on the 2nd and the 4th Thursday of April and August                                                                       |
      | * * 22 APR,AUG THU#4 *           | Every minute on the 22nd and the 4th Thursday of April and August                                                                            |
      | * * 4,5,7 apr,aug THU#4 *        | Every minute on the 4th, 5th and 7th and the 4th Thursday of April and August                                                                |
      | * * L APR,AUG thu#4 *            | Every minute on the last day and the 4th Thursday of April and August                                                                        |
      | * * 17W APR,AUG thu#4 *          | Every minute on the weekdays closest to April and August 17th and the 4th Thursday in April and August                                       |
