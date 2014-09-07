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
	testkey = Token.find_by_access_token "TestKey"
	unless testkey
		account = Account.create(email: "test@test.com", role: 'test', username: 'test', password: 'bob')
		Token.create access_token: "TestKey", account_id: account.id
	end

  Task.destroy_all()
	Task.create(id: "1", title: "Jogging in park")
	Task.create(id: "2", title: "Pick-up posters from post-office")
end

task :unseed do
	Account.destroy_all()
	Token.destroy_all()
  Task.destroy_all()
end
