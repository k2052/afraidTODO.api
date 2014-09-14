describe "Token" do
	it "should create a token" do
		token = FactoryGirl.create(:token)
		token = Token.find token.id
		token.should be_an_instance_of Token
	end

	it "should create a token with an user" do
		user = FactoryGirl.create(:user)
		user.tokens.first().should be_an_instance_of Token
	end

	it "should destroy a token" do 
		token = FactoryGirl.create(:token)
		token = Token.find token.id
		token.should be_an_instance_of Token
		token_id = token.id
		token.destroy()
		Token.find(token_id).should be_nil
	end

	it "should indicate when a token is expired" do
		token = FactoryGirl.build(:token_expired)
		token.expired?.should be_truthy
	end
end
