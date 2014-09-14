module Afraid
  module Api
    class Auth < Grape::API
      version 'v1', using: :header, vendor: 'afraidTODO'
      format :json

      if ::Afraid.env == :test
        get "/users/:username/set-test-user" do
          set_current_user User.find_by_username(params[:username])
        end
      end
    end
  end
end
