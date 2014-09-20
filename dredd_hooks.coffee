{before, after} = require 'hooks'

before "Authentication > Twitter Access Token > Create a user or authorize via twitter", (transaction) ->
  transaction.skip = true
  
before "Authentication > OAuthIO endpoint > Create or authorize a user via OAuthIO", (transaction) ->
  transaction.skip = true

before "Authentication > User > Remove a User", (transaction) ->
  transaction.skip = true

before "Authentication > Token > Remove a Token", (transaction) ->
  transaction.skip = true
