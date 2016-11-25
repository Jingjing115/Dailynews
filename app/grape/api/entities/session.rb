module API
  module Entities
    class Session < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.try :iso8601 }
      expose :id, :documentation => {
        type: "Integer",
        desc: "sessionID",
      }
      expose :session_id, :documentation => {
        type: "String",
        desc: "session_id",
      }
      expose :user, :documentation => {
        type: "Hash",
        desc: "用户"
      } do |instance, options|
        {
          id: instance.user.id,
          name: instance.user.name
        }
      end
    end
  end
end
