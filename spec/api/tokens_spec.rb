describe Afraid::Api::Tokens do
  before do
    header "CONTENT_TYPE", "application/json"
  end

  describe "authorized" do
    before do
      @user = FactoryGirl.create(:user)
      @token = @user.tokens.first()
      header 'X-Token', @token.access_token
    end

    it "should create another token for a user" do
      post "/auth/tokens"
      last_response.status.should == 201
      JSON.parse(last_response.body)['tokens'][0].should include("access_token")
    end

    it "should return all tokens owned by a user" do
      get "/auth/tokens"
      last_response.status.should == 200
      JSON.parse(last_response.body)['tokens'].count.should == @user.tokens.count()
    end
  end

  describe "unauthorized" do
    before do
      header 'X-Token', "BadKey"
    end

    it "should refuse to create a token" do
      post "/auth/tokens"
      last_response.status.should == 401
    end

    it "should refuse to return all tokens owned by a user" do
      get "/auth/tokens"
      last_response.status.should == 401
    end
  end
end
