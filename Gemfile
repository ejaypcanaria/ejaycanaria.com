source 'https://rubygems.org'

#Engines
gem 'admin', path: 'engines/admin'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use sqlite3 as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
gem 'bootstrap-sass', '~> 3.1.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
#gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'capistrano'
gem 'capistrano-rvm'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'capistrano-rails', '~> 1.1'

gem 'net-ssh', '~> 2.8.1', :git => "https://github.com/net-ssh/net-ssh"
gem 'unicorn'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem "devise"
gem "haml", ">= 3.0.0"
gem "haml-rails"
gem "jquery-rails"

group :development, :test do
  gem "rspec-rails", ">= 2.0.1"
  gem "factory_girl_rails", "~> 4.2.1"
end

group :development do
  gem "better_errors"
end

group :test do
  gem "faker", "~> 1.1.2"
  gem "capybara"
  gem "database_cleaner", "~> 0.9.1"
  gem "launchy", "~> 2.2.0"
end
