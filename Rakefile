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
		user = User.create(email: "test@test.com", role: 'test', username: 'test', password: 'bob')
		Token.create access_token: "TestKey", user_id: user.id
	end
   
	Task.create(id: "1", text: "Jogging in park")                  unless Task.find "1"
	Task.create(id: "2", text: "Pick-up posters from post-office") unless Task.find "2"
end

task :unseed do
	User.destroy_all()
	Token.destroy_all()
  Task.destroy_all()
end
