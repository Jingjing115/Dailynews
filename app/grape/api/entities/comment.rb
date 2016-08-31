module API
  module Entities
    class Comment < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.try :iso8601 }
      expose :id, :documentation => {
        type: "Integer",
        desc: "设备标识字符串 cf. 总则§2.3",
      }
      expose :id, :documentation => {
        type: "Integer",
        desc: "评论者ID"
      }
      expose :user_name, :documentation => {
        type: "String",
        desc: "评论者姓名",
      } do |instance, options|
        instance.user.name
      end
      expose :content, :documentation => {
        type: "Text",
        desc: "内容",
      }
    end
  end
end
