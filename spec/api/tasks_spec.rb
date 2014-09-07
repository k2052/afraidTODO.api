describe "Tasks" do
	before do
		header "CONTENT_TYPE", "application/json"
	end
	describe "authorized" do
		before do
			header 'X-Token', 'TestKey'
		end

		it "should return tasks" do
	    get "/tasks"
	    last_response.status.should == 200
	    last_response.body.should == TasksSerializer.new(Task.all()).to_json
		end

		it "should create a task" do
			task = FactoryGirl.build(:task)
			post "/tasks", TasksSerializer.new([task]).to_json
		  last_response.status.should == 201
		  JSON.parse(last_response.body)['tasks'][0]['title'].should == task.title
		end

		it "should return a task" do
			task = Task.first()
			get "/tasks/#{task.id}"
		  last_response.status.should == 200
		  last_response.body.should == TasksSerializer.new([task]).to_json
		end

		it "should destroy a task" do
			task = FactoryGirl.create(:task)
			delete "/tasks/#{task.id}"
		  last_response.status.should == 204
		end
	end

	describe "unauthorized" do
		before do
			header 'X-Token', 'BadKey'
		end

		it "should refuse to return tasks" do
	    get "/tasks"
	    last_response.status.should == 401
		end

		it "should refuse to create a task" do
			task = FactoryGirl.build(:task)
			post "/tasks"
	    last_response.status.should == 401
		end

		it "should refuse to return a task" do
			task = Task.first()
			get "/tasks/#{task.id}"
	    last_response.status.should == 401
		end

		it "should refuse to destroy a task" do
			task = FactoryGirl.create(:task)
			delete "/tasks/#{task.id}"
	    last_response.status.should == 401
		end
	end
end
