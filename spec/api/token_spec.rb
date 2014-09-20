describe Afraid::Api::Token do
  before do
    header "CONTENT_TYPE", "application/json"
  end

  describe "authorized" do
    before do
      @user = FactoryGirl.create(:user)
      @atoken = @user.tokens.first()
      @btoken = FactoryGirl.create(:token)
      @btoken_id = @btoken.id
      @user.tokens << @btoken
      header 'X-Token', @atoken.access_token
    end

    it "should delete a token" do
      delete "/auth/tokens/#{@btoken.id}"
      last_response.status == 200
      Token.find_by_id(@btoken_id).should == nil
    end
  end


  describe "unauthorized" do
    before do
      @token = FactoryGirl.create(:token)
      header 'X-Token', "BadKey"
    end

    it "should refuse to delete a token" do
      delete "/auth/tokens/#{@token.id}"
      last_response.status == 401
    end
  end
end 
