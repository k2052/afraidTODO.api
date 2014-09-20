module Afraid
  module Helpers
    module Auth
      def authenticated?
        error!('Unauthorized', 401) unless current_user
      end

      def session
        env['rack.session']
      end

      ##
      # Returns the current_user, it's an instance of User model.
      #
      def current_user
        @current_user ||= login_from_token
        @current_user ||= login_from_session
      end

      def set_current_user_session(user=nil)
        session[Afraid.config['session_id']] = user ? user.id : nil
        @current_user = user
      end

      def login_from_session
        ::User.find_by_id(session[Afraid.config['session_id']])
      end

      def login_from_token
        token = Token.find_by_access_token(params[:token] || request.headers['X-Token'])
        return unless token
        ::User.find token.user_id
      end

      def auth_hash
        return request.env["omniauth.auth"] if request.env["omniauth.auth"]
        hash = OmniAuth::AuthHash.new

        if params[:users]
          hash.provider = 'password'
          hash.password = params[:users][0]['password']
          hash.uid      = params[:users][0]['username'] if params[:users][0].include?('username')
          hash.info     = params[:users][0]
        end

        hash
      end
    end
  end
end
