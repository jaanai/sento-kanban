begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

APP_RAKEFILE = File.expand_path('../spec/test_app/Rakefile', __FILE__)
load 'rails/tasks/engine.rake'
load 'rails/tasks/statistics.rake'

require 'bundler/gem_tasks'

# Default task to RSpec and Cucumber
require 'rspec/core/rake_task'
# require 'cucumber/rake/task'

RSpec::Core::RakeTask.new
# Cucumber::Rake::Task.new

task default: [:spec]#, :cucumber]
