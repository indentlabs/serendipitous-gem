require 'rake/testtask'

default_tasks = []

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  default_tasks << :spec
rescue LoadError
  # no rspec available
end

Rake::TestTask.new do |t|
  t.pattern = 'test/*_test.rb'
end

default_tasks << :test
task default: default_tasks
