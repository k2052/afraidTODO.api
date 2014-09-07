module Afraid
  module Helpers
    module Resp
      def resp(obj)
        if obj.valid?
          obj
        else
          error!(obj.errors.to_json, 400)
        end
      end
    end
  end
end
