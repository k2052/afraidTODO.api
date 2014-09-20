describe Afraid::Api::User do
  before do
    header "CONTENT_TYPE", "application/json"
  end

  describe "authorized" do
    before do
      @user = FactoryGirl.create(:user)
      token = @user.tokens.first()
      header 'X-Token', token.access_token
    end

    it "should retrieve a user" do
      get "/users/#{@user.id}"
      last_response.status.should == 200
      last_response.body.should == UsersSerializer.new([@user]).to_json
    end

    it "should update a user" do
      @user.name = "bob"
      json = UsersSerializer.new([@user]).to_json

      @user.reload
      @user.name.should_not == "bob"

      put "/users/#{@user.id}", json
      last_response.status.should == 200

      @user.reload
      @user.name.should == "bob"
    end

    it "should delete a user" do
      delete "/users/#{@user.id}"
      last_response.status.should == 204
    end
  end


  describe "unauthorized" do
    before do
      header 'X-Token', "BadKey"
      @user = FactoryGirl.create(:user)
    end

    it "should refuse to retrieve a user" do
      get "/users/#{@user.id}"
      last_response.status.should == 401
    end

    it "should refuse to update a user" do
      put "/users/#{@user.id}"
      last_response.status.should == 401
    end

    it "should refuse to delete a user" do
      delete "/users/#{@user.id}"
      last_response.status.should == 401
    end
  end
end 
