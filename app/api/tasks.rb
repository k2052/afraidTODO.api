module Afraid
	module Api
		class Tasks < Grape::API
		  version 'v1', using: :header, vendor: 'tasks'
		  format :json

      before do
        authenticated?
      end

      namespace :tasks do
			  get do
			  	TasksSerializer.new(Task.all())
			  end
        
			  post do
			  	task = Task.create params[:tasks][0]
			  	status 201
			  	TasksSerializer.new([task])
			  end

			  get ':id' do
			  	task = Task.find params[:id]
					error!("Not Found", 404) unless task
			  	TasksSerializer.new([task])
			  end 

			  delete ':id' do
			  	task = Task.find(params[:id])
					error!("Not Found", 404) unless task
			  	task.destroy()
			  	status 204
			  end
      end
		end
	end
end
