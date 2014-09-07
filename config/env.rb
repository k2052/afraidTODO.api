$:.unshift File.dirname(__FILE__)
env = (ENV['RACK_ENV'] || :development)

Afraid.config               = YAML::load("config.yml")[env]
Afraid.env                  = env
Afraid.config['session_id'] = ENV['SESSION_ID'] || "test-session-id"

specific_environment = "envs/#{env}.rb"
require specific_environment if File.exists? specific_environment

Dir[File.expand_path("../initializers/*.rb", __FILE__)].each do |f|
  require f
end
