source 'https://rubygems.org'
ruby "2.1.1"

gem 'grape', '~> 0.7.0'
gem 'oat', :git => "git://github.com/ismasan/oat.git"
gem 'puma'
gem 'rake'
gem 'rack-ssl-enforcer'
gem 'rack-cors', require: 'rack/cors'
gem 'bson_ext', '~> 1.10.0', :require => 'mongo'
gem 'mongo_mapper', '~> 0.13.0', :require => 'mongo_mapper'
gem 'omniauth-identity', require: 'omniauth-identity'

group :development do
  gem 'rerun'
end

group :test do
  gem 'rspec'
  gem 'rack-test', require: 'rack/test'
  gem 'guard'
  gem 'guard-rspec'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'rb-inotify', '~> 0.8.8', require: false
  gem 'ffaker', require: 'ffaker'
  gem 'factory_girl'
  gem 'shoulda-matchers'
end
