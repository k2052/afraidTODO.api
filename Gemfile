source 'https://rubygems.org'
ruby "2.1.1"

gem 'grape', '~> 0.7.0'
gem 'oat', :git => 'git://github.com/ismasan/oat.git'
gem 'puma'
gem 'rake'
gem 'bcrypt-ruby', '~> 3.1.5', require: 'bcrypt'
gem 'rack-ssl-enforcer'
gem 'rack-cors', require: 'rack/cors'
gem 'bson_ext', '~> 1.10.0', :require => 'mongo'
gem 'mongo_mapper', '~> 0.13.0', :require => 'mongo_mapper'
gem 'mongomapper_ext', git: 'git://github.com/k2052/mongomapper_ext.git'
gem 'omniauth'
gem 'omniauth-twitter-access-token'
gem 'omniauth-oauthio', '~> 0.2.2'

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
