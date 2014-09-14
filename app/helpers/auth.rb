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

		  ##
		  # Override the current_user, you must provide an instance of User model.
		  #
		  # @example
		  #     set_current_user(User.authenticate(params[:email], params[:password])
		  #
		  def set_current_user(user=nil)
		    session[Afraid.config['session_id']] = user ? user.id : nil
		    @current_user = user
		  end

	    def login_from_session
	      User.find_by_id(session[Afraid.config['session_id']])
	    end

			def login_from_token
				token = Token.find_by_access_token(params[:token] || request.headers['X-Token'])
				return unless token
				User.find token.user_id
			end
		end
	end
end
