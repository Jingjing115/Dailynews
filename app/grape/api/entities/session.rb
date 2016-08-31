module API
  module Entities
    class Session < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.try :iso8601 }
      expose :id, :documentation => {
        type: "Integer",
        desc: "设备标识字符串 cf. 总则§2.3",
      }
      expose :session_id, :documentation => {
        type: "String",
        desc: "session_id",
      }
      expose :user_id, :documentation => {
        type: "Integer",
        desc: "用户ID",
      }
      expose :user_name, :documentation => {
        type: "String",
        desc: "用户姓名"
      } do |instance, options|
        instance.user.name
      end
    end
  end
end
