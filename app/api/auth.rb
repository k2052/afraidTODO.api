module Afraid
	module Api
		class Auth < Grape::API
		  version 'v1', using: :header, vendor: 'tasks'
		  format :json

		  if ::Afraid.env == :test
				get "/accounts/:username/set-test-account" do
					set_current_account Account.find_by_username(params[:username])
				end
			end
		end
	end
end
