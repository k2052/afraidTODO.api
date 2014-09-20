module Afraid
  module Api
    class Auth < Grape::API
      version 'v1', using: :header, vendor: 'afraidTODO'
      format :json
      
      namespace :auth do
        namespace :sessions do
          post do
            if current_user
              set_current_user_session current_user
            else
              user = ::User.authenticate_with_email_pass params[:users][0]['email'], params[:users][0]['password']
              if user
                set_current_user_session user
              else
                error!('Bad user or Pass', 400)
              end
            end
            
            UsersSerializer.new([current_user])
          end
        end
      end
      
      ##
      # Provided for ominauth
      # Maybe we only let come from our server?
      ##
      post '/auth/:provider/callback' do
        omniAuthResp()
      end

      post "/auth/oauthio/:provider/callback" do
        omniAuthResp()
      end
    end
  end
end
