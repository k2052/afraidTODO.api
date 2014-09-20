module Afraid
  module Api
    class User < Grape::API
      version 'v1', using: :header, vendor: 'afraidTODO'
      format :json
      
      before do
        authenticated?
      end

      namespace :users do
        route_param :id do
          get do
            UsersSerializer.new([current_user])
          end 

          put do
            current_user.update_attributes! params[:users][0]
            userResp current_user
          end

          delete do
            current_user.archive() # do a safe delete of user
            status 204
          end
        end
      end
    end
  end
end
