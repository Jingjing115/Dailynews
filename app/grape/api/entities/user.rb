module API
  module Entities
    class User < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.try :iso8601 }
      expose :id, :documentation => {
        type: "Integer",
        desc: "设备标识字符串 cf. 总则§2.3",
      }
      expose :name, :documentation => {
        type: "String",
        desc: "用户姓名",
      }
      expose :email, :documentation => {
        type: "String",
        desc: "用户邮箱"
      }
    end
  end
end
