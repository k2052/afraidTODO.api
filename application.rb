module Afraid
  def self.config
    @config ||= {}
  end

  def self.config=(config)
    @config = config
  end

  def self.env
    @env
  end

  def self.env=(env)
    @env = env.to_sym
  end
end

require './config/boot'
require './config/env'

current_dir = File.dirname(__FILE__)

['app', 'app/api', 'app/helpers', 'app/models' ].each do |path|
  $LOAD_PATH.unshift(File.join(current_dir, path))
end

$LOAD_PATH.unshift(current_dir)

['app/commands', 'app/entities', 'app/representers', 'app/serializers', 'app/helpers', 'app/middleware', 'app/models', 'app/api' ].each do |path|
  Dir[File.expand_path("../#{path}/*.rb", __FILE__)].each do |f|
    require f
  end
end

require 'api'
require 'app'
