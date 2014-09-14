module Afraid
  module Api
    class Tasks < Grape::API
      version 'v1', using: :header, vendor: 'afraidTODO'
      format :json

      before do
        authenticated?
      end

      namespace :tasks do
        get do
          TasksSerializer.new(current_user.tasks())
        end
        
        post do
          task = current_user.tasks.create params[:tasks][0]
          taskResp task
        end
      end
    end
  end
end
