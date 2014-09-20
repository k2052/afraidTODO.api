module Afraid
  module Api
    class Task < Grape::API
      version 'v1', using: :header, vendor: 'afraidTODO'
      format :json
  
      before do
        authenticated?
      end

      namespace :tasks do
        route_param :id do
          before do 
            @task = current_user.tasks.find params[:id]
            error!("Not Found", 404) unless @task
          end

          get do
            TasksSerializer.new([@task])
          end 

          put do
            @task.update_attributes! params[:tasks][0]
            taskResp @task
          end

          delete do
            @task.destroy()
            status 204
          end
        end
      end
    end
  end
end
