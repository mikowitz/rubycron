require 'rubycron'

When /^I parse the expression "(.*?)"$/ do |expression|
  @parsed = Rubycron.parse(expression)
end

Then /^I return "(.*?)"$/ do |expected|
  assert_equal expected, @parsed
end
