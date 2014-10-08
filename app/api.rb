module Afraid
  class API < Grape::API
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
