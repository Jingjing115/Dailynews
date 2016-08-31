module API
  module Entities
    class Blog < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.try :iso8601 }
      expose :id, :documentation => {
        type: "Integer",
        desc: "设备标识字符串 cf. 总则§2.3",
      }
      expose :user_id, :documentation => {
        type: "Integer",
        desc: "发布者ID"
      }
      expose :user_name, :documentation => {
        type: "String",
        desc: "发布者姓名",
      } do |instance, options|
        instance.user.name
      end
      expose :"title", :documentation => {
        type: "String",
        desc: '标题',
      }
      expose :content, :documentation => {
        type: "Text",
        desc: "内容",
      }
      expose :comments,:documentation => {
        type: "Array",
        desc: '评论'
      }, with: API::Entities::Comment
    end
  end
end
