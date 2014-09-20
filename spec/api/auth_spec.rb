describe Afraid::Api::Auth do 
  it "should return a session" do
    body =   {
      users: [
        {
          email: "bob@example.com",
          password: "pass" 
        }
      ]
    }

    user = User.find_by_email "bob@example.com"
    post "/auth/sessions", body

    last_response.status.should == 201
    last_response.body.should == UsersSerializer.new([user]).to_json
  end

  describe "OmniAuth" do
    before do
      mock_auth_hash()
    end

    it "should login using twitter" do
      user = User.find_by_email "twitterUser@example.com"

      post "/auth/twitter_access_token/callback", nil, "omniauth.auth" => OmniAuth.config.mock_auth[:twitter_access_token]
      last_response.status.should == 201
      last_response.body.should == UsersSerializer.new([user]).to_json
    end

    it "should login using oauth.io github" do
      user = User.find_by_email "OAuthIOUser@example.com"

      post "/auth/oauthio/github/callback", nil, "omniauth.auth" => OmniAuth.config.mock_auth[:oauthio]
      last_response.status.should == 201
      last_response.body.should == UsersSerializer.new([user]).to_json
    end
  end
end
