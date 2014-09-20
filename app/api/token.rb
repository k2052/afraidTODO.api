module Afraid
  module Api
    class Token < Grape::API
      version 'v1', using: :header, vendor: 'afraidTODO'
      format :json
  
      before do
        authenticated?
      end
      
      namespace :auth do
        namespace :tokens do
          route_param :id do
            before do 
              @token = current_user.tokens.find params[:id]
              error!("Not Found", 404) unless @token
            end

            delete do
              @token.destroy()
              status 204
            end
          end
        end
      end
    end
  end
end