source 'http://rubygems.org'

gemspec

group :development do
  gem 'rake'
  gem 'yard'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
end

group :development, :test do
  gem 'rake'
  gem 'rack-test'
  gem 'rspec', '~> 2.9'
  gem 'bundler'
  gem 'pry'
  gem 'faraday'
  gem 'thin'

  # integration
  gem 'capybara-webkit'
  gem 'em-eventsource'
  gem 'em-http-request'
  gem 'sinatra'
end

# Optional groups. To skip, run:
#
# bundle install --without debug:darwin:heroku

# debugger for 1.9 only
group :debug do
  gem 'debugger'
end

# Mac specific
group :darwin do
  gem 'rb-fsevent'
  gem 'growl'
end

# For deploying Rails demo application to heroku
group :heroku do
  gem 'rails', '3.2.3'
  gem 'jquery-rails'
  gem "twitter-bootstrap-rails"

  gem 'grape', :git => 'https://github.com/intridea/grape', :branch => 'frontier'
  gem 'redis'
  gem 'hiredis'
  gem 'thin'
end