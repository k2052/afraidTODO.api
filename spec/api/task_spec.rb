describe "Task" do
  before do
    header "CONTENT_TYPE", "application/json"
  end

  describe "authorized" do
    before do
      header 'X-Token', 'TestKey'
      @user = Token.find_by_access_token("TestKey").user
    end

    it "should return a task" do
      task = @user.tasks.first()
      get "/tasks/#{task.id}"
      last_response.status.should == 200
      last_response.body.should == TasksSerializer.new([task]).to_json
    end

    it "should update a task" do
      task = FactoryGirl.build(:task_undone)
      @user.tasks << task
      
      task.do
      json = TasksSerializer.new([task]).to_json

      task.reload
      task.done.should == false

      put "/tasks/#{task.id}", json
      last_response.status.should == 200

      task.reload
      task.done.should == true
    end

    it "should destroy a task" do
      task = FactoryGirl.build(:task)
      @user.tasks << task

      delete "/tasks/#{task.id}"
      last_response.status.should == 204
    end
  end

  describe "unauthorized" do
    before do
      header 'X-Token', 'BadKey'
      @user = Token.find_by_access_token("TestKey").user
    end

    it "should refuse to return a task" do
      task = @user.tasks.first()
      get "/tasks/#{task.id}"
      last_response.status.should == 401
    end

    it "should refuse to update a task" do
      task = @user.tasks.first()
      put "/tasks/#{task.id}"
      last_response.status.should == 401
    end

    it "should refuse to destroy a task" do
      task = @user.tasks.first()
      delete "/tasks/#{task.id}"
      last_response.status.should == 401
    end
  end

  describe "wrong user" do
    before do
      header 'X-Token', 'TestKey'
    end

    it "should return 404 if the task belongs to another user" do
      task = FactoryGirl.create(:task)
      get "/tasks/#{task.id}"
      last_response.status.should == 404
    end

    it "should return 404 if the task being updated is the task of another user" do
      task = FactoryGirl.create(:task)
      put "/tasks/#{task.id}"
      last_response.status.should == 404
    end

    it "should return 404 if the task being destroyed is the task of another user" do
      task = FactoryGirl.create(:task)
      delete "/tasks/#{task.id}"
      last_response.status.should == 404
    end
  end
end
