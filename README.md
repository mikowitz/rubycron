## Does this sound like you?

* you _sorta_ know how to write a [cron][cron_wiki] expression
* you have to write them from time to time, but...
* you know that getting the answer from a friend (or the internet) isn't going to help you learn how to write them for yourself
* you'd just like to know if that cron expression you just wrote does what you meant it to

Rubycron has got you covered.

# Rubycron - it's not just a [river in Italy][rubicon]!

It's also a 'spell-checker' for cron expressions. Ask it to parse that cron
expression you just wrote, and it'll let you know if it's gonna do anything
close to what you meant it to.

See Usage below for examples.

## Installation

Add this line to your application's Gemfile:

    gem 'rubycron'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubycron

## Usage

    irb > require 'rubycron'
     => true
    irb > Rubycron.parse("3 4 22 5 * 2015")
     => "04:03 on May 22, 2015"
    irb > Rubycron.parse("30 6 * * 6L *")
     => "06:30 on the last Saturday of every month"
    irb > Rubycron.parse("10-15 6,12,18 * NOV THU#4 *")
    => "Every minute between 06:10 and 06:15, 12:10 and 12:15 and 18:10 and 18:15 on the 4th Thursday of November"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2013 Michael Berkowitz (@hal678). See LICENSE.txt for further details.

[cron_wiki]: http://en.wikipedia.org/wiki/Cron
[rubicon]: http://en.wikipedia.org/wiki/Rubicon
