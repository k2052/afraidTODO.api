module Afraid
  class App
    class << self
      def instance
        @instance ||= Rack::Builder.new do
          api = Afraid::API

          use Rack::Cors do
            allow do
              origins '*'
              resource '*', headers: :any, methods: :get
            end
          end

          use Rack::Session::Cookie, secret: ENV['SESSION_COOKIE_SECRET'] || SecureRandom.base64(128)

          if ['development', 'test'].include? ENV['RACK_ENV']
            api.logger.info "Enabling Developer authentication."

            use OmniAuth::Builder do
              provider :developer
            end   
          end

          if ENV['TWITTER_KEY'] && ENV['TWITTER_SECRET']
            api.logger.info "Enabling Twitter authentication."

            use OmniAuth::Builder do
              provider :twitter_access_token, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
            end
          end

          if ENV['OAUTHIO_KEY'] && ENV['OAUTHIO_SECRET']
            use OmniAuth::Builder do
              provider :oauthio, ENV['OAUTHIO_KEY'], ENV['OAUTHIO_SECRET'], :jwt_secret => ENV['OAUTHIO_JWT_SECRET']
            end
          end

          run api
        end.to_app
      end
    end
  end
end
