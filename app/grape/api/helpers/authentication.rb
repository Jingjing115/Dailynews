module API
  module Helpers
    module Authentication
      def current_user
        auth_header = @env["HTTP_AUTHORIZATION"] || ""
        User.find_by_auth_header(auth_header) || error!({error: "Unauthorized"}, 401)
      end
    end
  end
end
