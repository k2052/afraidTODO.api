On a OAuth login event the ID provides the security? 

## User flow

App should handle all the smarts. No OAuth flow on REST side. Only user creation and retrieval.

Security issue

1. Attacker registers with fake uid + provider + email all the normal details.
2. Real user logins. We should always check uid
3. Attacker uses token to access user data

Tokens should decay and invalidate

### Oauth Flow

1. User Goes to Sign In With Twitter
2. redirections all happen
3. Now we have a user hash
4. We use this to register and get a token

All endpoints go to create user which returns a user.

We just need ominauth providers which accept access token.
Most ominauth provdiers accept a manual callback phase. Just pass the correct parameters as a post to the callback url

We should write tests that work with them.

