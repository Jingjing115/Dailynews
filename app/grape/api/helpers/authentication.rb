module API
  module Helpers
    module Authentication
      def current_user
        auth_header = @env["HTTP_AUTHORIZATION"] || ""
        Session.find_by_auth_header(auth_header).try(:user) || error!({error: "Unauthorized"}, 401)
      end
    end
  end
end
