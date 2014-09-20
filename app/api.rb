module Afraid
  class API < Grape::API
    version 'v1', using: :header, vendor: 'tribute', strict: false
    format :json

    helpers Afraid::Helpers::Auth
    helpers Afraid::Helpers::Resp

    mount Afraid::Api::Auth
    mount Afraid::Api::Tasks
    mount Afraid::Api::Task
    mount Afraid::Api::Users
    mount Afraid::Api::User
    mount Afraid::Api::Tokens
    mount Afraid::Api::Token
  end
end
