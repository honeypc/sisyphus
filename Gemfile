# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.2'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Builds ActiveRecord named scopes that take advantage of PostgreSQL’s full text search
gem 'pg_search'

# Object-based searching
gem 'ransack', github: 'activerecord-hackery/ransack', branch: 'main'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
# gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Fast JSON serializer for Rails based on Jbuilder with concept of views
gem 'to_j'

# Use Redis adapter to run Action Cable in production
gem 'redis', '>= 4.0.1'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Vite.js in Ruby, bringing joy to your JavaScript experience
gem 'vite_rails'

# The Best Pagination Ruby Gem (https://github.com/ddnexus/pagy)
gem 'pagy'

# Flexible authentication solution for Rails with Warden(https://github.com/heartcombo/devise)
gem 'devise'

# About Token based authentication for Rails JSON APIs. Designed to work with jToker and ng-token-auth.
gem 'devise_token_auth', '>= 1.2.2', git: 'https://github.com/lynndylanhurley/devise_token_auth'

# Easy activity tracking for models - similar to Github's Public Activity
gem 'public_activity'

# Easy multi-tenancy for Rails in a shared database setup.
gem 'acts_as_tenant'

# FriendlyId is the “Swiss Army bulldozer” of slugging and permalink plugins for ActiveRecord
gem 'friendly_id', '~> 5.5.0'

# Rails I18n de-facto standard library for ActiveRecord model/data translation.
gem 'globalize', git: 'https://github.com/globalize/globalize'

# Globalize support for FriendlyId
gem 'friendly_id-globalize'

# Minimal authorization through OO design and pure Ruby classes
gem 'pundit'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]

  # Fake data for development and testing
  gem 'faker', '3.1.0'

  # A RuboCop extension focused on enforcing Rails best practices and coding conventions.
  gem 'rubocop-rails', require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Easily add '# frozen_string_literal: true' comments to the top of all your project's Ruby files
  gem 'magic_frozen_string_literal'

  # The gem enhances Exception#message by adding a short explanation where the exception is raised
  gem 'error_highlight', '~> 0.6.0', platforms: [:ruby]
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end
