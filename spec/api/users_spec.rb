describe Afraid::Api::Users do
  before do
    header "CONTENT_TYPE", "application/json"
  end

  it "should create a user" do
    user = FactoryGirl.build(:user)
    user_h = UsersSerializer.new([user]).to_hash
    user_h[:users][0][:password] = user.password

    post "/users", user_h.to_json
    last_response.status.should == 201
    JSON.parse(last_response.body)['users'][0]['email'].should == user.email
  end
end 
