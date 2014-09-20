module Afraid
  module Api
    class Users < Grape::API
      version 'v1', using: :header, vendor: 'afraidTODO'
      format :json
      
      namespace :users do
        post do
          user = ::User.create_from_auth_hash auth_hash
          userResp user
        end
      end
    end
  end
end