@wip
Feature: Parsing a cron expression with dates
  In order to give anyone who doesn't have cron format 100% down cold
  a way to check that they've got the correct expression

  Scenario Outline: Parsing cron expressions
    When I parse the expression "<cron_expression>"
    Then I return "<human_readable>"

    Examples:
      | cron_expression             | human_readable                                                                                  |
      | * * 3-20/3 * * *            | Every minute on every 3rd day from the 3rd to the 20th of every month|
      | * * 1-15 * * *              | Every minute on the 1st to the 15th of every month|
      | * * */5 * * *               | Every minute on every 5th day of every month|
      | * * 22 * * *                | Every minute on the 22nd of every month|
      | * * 4,5,7 * * *             | Every minute on the 4th, 5th and 7th of every month|
      | * * L * * *                 | Every minute on the last day of every month|
      | * * 17W * * *               | Every minute on the weekday closest to the 17th of every month|
      | * * * 1-11/2 * *            | Every minute on every day of every 2nd month from January to November|
      | * * 3-20/3 1-11/2 * *       | Every minute on every 3rd day from the 3rd to the 20th of every 2nd month from January to November|
      | * * 1-15 1-11/2 * *         | Every minute on the 1st to the 15th of every 2nd month from January to November|
      | * * */5 1-11/2 * *          | Every minute on every 5th day of every 2nd month from January to November| 
      | * * 22 1-11/2 * *           | Every minute on the 22nd of every 2nd month from January to November|
      | * * 4,5,7 1-11/2 * *        | Every minute on the 4th, 5th and 7th of every 2nd month from January to November|
      | * * L 1-11/2 * *            | Every minute on the last day of every 2nd month from January to November|
      | * * 17W 1-11/2 * *          | Every minute on the weekday closest to the 17th of every 2nd month from January to November|
      | * * * 3-7 * *            | Every minute on every day of every month from March to July|
      | * * 3-20/3 3-7 * *       | Every minute on every 3rd day from the 3rd to the 20th of every month from March to July|
      | * * 1-15 3-7 * *         | Every minute on the 1st to the 15th of every month from March to July|
      | * * */5 3-7 * *          | Every minute on every 5th day of every month from March to July| 
      | * * 22 3-7 * *           | Every minute on the 22nd of every month from March to July|
      | * * 4,5,7 3-7 * *        | Every minute on the 4th, 5th and 7th of every month from March to July|
      | * * L 3-7 * *            | Every minute on the last day of every month from March to July|
      | * * 17W 3-7 * *          | Every minute on the weekday closest to the 17th of every month from March to July|
      | * * * */4 * *            | Every minute on every day of every 4th month|
      | * * 3-20/3 */4 * *       | Every minute on every 3rd day from the 3rd to the 20th of every 4th month|
      | * * 1-15 */4 * *         | Every minute on the 1st to the 15th of every 4th month|
      | * * */5 */4 * *          | Every minute on every 5th day of every 4th month| 
      | * * 22 */4 * *           | Every minute on the 22nd of every 4th month|
      | * * 4,5,7 */4 * *        | Every minute on the 4th, 5th and 7th of every 4th month|
      | * * L */4 * *            | Every minute on the last day of every 4th month|
      | * * 17W */4 * *          | Every minute on the weekday closest to the 17th of every 4th month|
      | * * * 2/5 * *            | Every minute on every day of every 5th month from February to December|
      | * * 3-20/3 2/5 * *       | Every minute on every 3rd day from the 3rd to the 20th of every 5th month from February to December|
      | * * 1-15 2/5 * *         | Every minute on the 1st to the 15th of every 5th month from February to December|
      | * * */5 2/5 * *          | Every minute on every 5th day of every 5th month from February to December| 
      | * * 22 2/5 * *           | Every minute on the 22nd of every 5th month from February to December|
      | * * 4,5,7 2/5 * *        | Every minute on the 4th, 5th and 7th of every 5th month from February to December|
      | * * L 2/5 * *            | Every minute on the last day of every 5th month from February to December|
      | * * 17W 2/5 * *          | Every minute on the weekday closest to the 17th of every 5th month from February to December|
      | * * * 5 * *            | Every minute on every day of May|
      | * * 3-20/3 5 * *       | Every minute on every 3rd day from the 3rd to the 20th of May|
      | * * 1-15 5 * *         | Every minute on the 1st to the 15th of May|
      | * * */5 5 * *          | Every minute on every 5th day of May| 
      | * * 22 5 * *           | Every minute on May 22nd|
      | * * 4,5,7 5 * *        | Every minute on May 4th, 5th and 7th|
      | * * L 5 * *            | Every minute on the last day of May|
      | * * 17W 5 * *          | Every minute on the weekday closest to May 17th|
      | * * * APR,AUG * *            | Every minute on every day of April and August|
      | * * 3-20/3 apr,aug * *       | Every minute on every 3rd day from the 3rd to the 20th of April and August|
      | * * 1-15 APR,AUG * *         | Every minute on the 1st to the 15th of April and August|
      | * * */5 apr,aug * *          | Every minute on every 5th day of April and August| 
      | * * 22 APR,AUG * *           | Every minute on the 22nd of April and August|
      | * * 4,5,7 apr,aug * *        | Every minute on the 4th, 5th and 7th of April and August|
      | * * L APR,AUG * *            | Every minute on the last day of April and August|
      | * * 17W APR,AUG * *          | Every minute on the weekdays closest to April and August 17th|
