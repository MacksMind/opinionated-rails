source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.2'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development do
  # Annotate models, factories, and spec with table layout
  gem 'annotate'
  # Add performance cops
  gem 'rubocop-performance'
  # Add Rails cops
  gem 'rubocop-rails'
  # Add Rspec cops
  gem 'rubocop-rspec'
  # Add slim generator
  gem 'slim-rails'
end

group :development, :test do
  # Help kill N+1 queries
  gem 'bullet'
  # For debugging
  gem 'pry-byebug'
  # Testing
  gem 'rspec-rails'
end

group :test do
  # Cucumber testing
  gem 'cucumber-rails', require: false
  # Empty database when needed during testing
  gem 'database_cleaner'
  # Factories for specs
  gem 'factory_bot_rails'
  # Supports save_and_open_page
  gem 'launchy'
  # Assigns in Rspec
  gem 'rails-controller-testing'
  # Mocks in Rspec
  gem 'rspec-activemodel-mocks'
  # Code coverage
  gem 'simplecov', require: false
end

# Authentication
gem 'devise'
# Pagination
gem 'kaminari'
# Use initials for avatar
gem 'letter_avatar'
# SEO meta tags
gem 'meta-tags', require: 'meta_tags'
# Authorization
gem 'pundit'
# Search form gem
gem 'ransack'
# Add slim. Note the generator is in the dev group. Might save a touch on bundle size by not using slim-rails here.
gem 'slim'
