source 'https://rubygems.org'

# Declare your gem's dependencies in sento-kanban.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]

gem 'dragula-rails', git: 'https://github.com/Sento/dragula-rails'

group :test do
  gem 'cucumber-rails', '~> 1.4.5', require: false
  gem 'pg'
  gem 'ffaker', '~> 2.3.0'
  gem 'rspec-rails', '~> 3.5'
  gem 'shoulda-matchers', '~> 3.1.1'
  gem 'machinist', '~> 2.0'
  gem 'database_cleaner', '~> 1.5.3'
  gem 'capybara', '~> 2.11.0'
  gem 'capybara-screenshot', '~> 1.0.14'
  gem 'poltergeist', '~> 1.12.0'
end

group :development do
  gem 'rubocop'
end
