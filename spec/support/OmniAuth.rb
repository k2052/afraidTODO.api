module OmniAuthMacros
  def mock_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:twitter_access_token] = OmniAuth::AuthHash.new({
      'provider'  => 'twitter',
      'uid'       => '123545twitter',
      'info' => {
        'email'    => 'twitterUser@example.com',
        'name'     => 'mockuser',
        'nickname' => 'bob',
        'image'    => 'mock_user_thumbnail_url'
      },
      'credentials' => {
        'token'     => 'mock_token',
        'secret'    => 'mock_secret'
      }
    })

    OmniAuth.config.mock_auth[:oauthio] = OmniAuth::AuthHash.new({
      'provider'  => 'github',
      'uid'       => '123545github',
      'info' => {
        'email'    => 'OAuthIOUser@example.com',
        'name'     => 'mockusergithub',
        'nickname' => 'bob',
        'image'    => 'mock_user_thumbnail_url'
      },
      'credentials' => {
        'token'     => 'mock_token',
        'secret'    => 'mock_secret'
      }
    })
  end
end
