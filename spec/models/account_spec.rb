describe "Account" do
	it "should create an account" do
		account = FactoryGirl.create(:account)
		account = Account.find account.id
		account.should be_an_instance_of Account
	end

	it "should destroy an account" do 
		account = FactoryGirl.create(:account)
		account = Account.find account.id
		account.should be_an_instance_of Account
		account_id = account.id
		account.destroy()
		Account.find(account_id).should be_nil
	end
end
