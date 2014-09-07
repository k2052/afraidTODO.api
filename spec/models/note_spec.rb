describe "Task" do
	it "should create an task" do
		task = FactoryGirl.create(:task)
		task = Task.find task.id
		task.should be_an_instance_of Task
	end

	it "should destroy an task" do 
		task = FactoryGirl.create(:task)
		task = Task.find task.id
		task.should be_an_instance_of Task
		task_id = task.id
		task.destroy()
		Task.find(task_id).should be_nil
	end
end
