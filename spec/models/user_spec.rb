describe "User" do
  it "should create an user" do
    user = FactoryGirl.create(:user)
    user = User.find user.id
    user.should be_an_instance_of User
  end

  it "should destroy an user" do 
    user = FactoryGirl.create(:user)
    user = User.find user.id
    user.should be_an_instance_of User
    user_id = user.id
    user.destroy()
    User.find(user_id).should be_nil
  end
end
