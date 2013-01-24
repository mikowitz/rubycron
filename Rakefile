#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features)

Cucumber::Rake::Task.new('features:wip', 'Run work-in-progress cukes') do |task|
  task.profile = 'wip'
end

task default: :features
