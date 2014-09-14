describe "Tasks Collection" do
	before do
		header "CONTENT_TYPE", "application/json"
	end

	describe "authorized" do
		before do
			header 'X-Token', 'TestKey'
			@user = Token.find_by_access_token("TestKey").user
		end

		it "should return all tasks" do
		  get "/tasks"
		  last_response.status.should == 200
		  last_response.body.should == TasksSerializer.new(@user.tasks.all()).to_json
		end

		it "should create a task" do
			task = FactoryGirl.build(:task)
			post "/tasks", TasksSerializer.new([task]).to_json
		  last_response.status.should == 201
		  JSON.parse(last_response.body)['tasks'][0]['text'].should == task.text
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
	end

	describe "wrong user" do
		before do
			header 'X-Token', 'TestKey'
		end

		it "should return tasks only belonging to the user with the TestKey" do
			FactoryGirl.create(:task)
			user = Token.find_by_access_token("TestKey").user

	    get "/tasks"
	    tasks = last_response.body
	    tasks.should == TasksSerializer.new(user.tasks()).to_json
		end
	end
end
