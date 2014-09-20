#!/usr/bin/env rake
require File.expand_path('../application', __FILE__)

if Afraid.env == 'test'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task :default => :spec
else 
  task :default => :seed
end

task :seed do
  unless Token.find_by_access_token "TestKey"
    user = User.create(name: "test", email: "test@test.com", username: 'test', password: 'pass')
    Token.create access_token: "TestKey", user_id: user.id
  end

  User.create name: "test", email: "bob@example.com", password: "pass"
  User.create email: "twitterUser@example.com", uid: "123545twitter", provider: "twitter" 
  User.create email: "OAuthIOUser@example.com", uid: "123545github",  provider: "github" 

  user = Token.find_by_access_token("TestKey").user
  user.tasks.create(id: "1", text: "Jogging in park")                  unless Task.find "1"
  user.tasks.create(id: "2", text: "Pick-up posters from post-office") unless Task.find "2"
end

task :unseed do
  User.destroy_all()
  Token.destroy_all()
  Task.destroy_all()
end
