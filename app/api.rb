module Afraid
  class API < Grape::API
    version 'v1', using: :header, vendor: 'tribute', strict: false
    format :json

    helpers Afraid::Helpers::Auth
    helpers Afraid::Helpers::Resp

    mount Afraid::Api::Auth
    mount Afraid::Api::Tasks
  end
end
