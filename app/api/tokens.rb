module Afraid
  module Api
    class Tokens < Grape::API
      version 'v1', using: :header, vendor: 'afraidTODO'
      format :json
  
      before do
        authenticated?
      end

      namespace :auth do
        namespace :tokens do
          get do
            TokensSerializer.new(current_user.tokens())
          end
          
          post do
            TokensSerializer.new([current_user.tokens.create()])
          end
        end
      end
    end
  end
end
