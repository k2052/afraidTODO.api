module Afraid
  module Helpers
    module Resp
      def valid?(object)
        valid = true
        # `valid?` method may override existing errors, so check for those first
        valid &&= object.valid? if object.respond_to?(:valid?)
        valid &&= (object.errors.count == 0) if object.respond_to?(:errors)
        return valid
      end

      def resp(obj)
        if valid? obj
          obj
        else
          error!(obj.errors.to_json, 400)
        end
      end

      def taskResp(task)
        if task.valid?
          TasksSerializer.new([task])
        else
          error!({errors: task.errors.to_a}, 400)
        end
      end

      def userResp(user)
        if user.valid?
          UsersSerializer.new([user])
        else
          error!({errors: user.errors.to_a}, 400)
        end
      end

      def omniAuthResp
        user = User.find_or_create_from_auth_hash auth_hash
        error!("Not Found", 404) unless user
        userResp user 
      end
    end
  end
end
