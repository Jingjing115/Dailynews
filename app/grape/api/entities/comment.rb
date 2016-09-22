module API
  module Entities
    class Comment < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.try :iso8601 }
      expose :id, :documentation => {
        type: "Integer",
        desc: "commentID",
      }
      expose :blog_id, :documentation => {
        type: "Integer",
        desc: "blogID"
      }
      expose :author_id, :documentation => {
        type: "Integer",
        desc: "评论者ID"
      } do |instance, options|
        instance.user.id
      end
      expose :author_name, :documentation => {
        type: "Integer",
        desc: "评论者name"
      } do |instance, options|
        instance.user.name
      end
      expose :type, :documentation => {
        type: "String",
        desc: "评论或回复"
      } do |instance, options|
        instance.source.present? ? '回复' : '评论'
      end
      expose :source_user_name, :documentation => {
        type: "String",
        desc: "回复对象",
      }, if: lambda { |instance, options|
        instance.source.present?
      } do |instance, options|
        instance.source.user.name
      end
      expose :created_at, :documentation => {
        type: "Date",
        desc: "评论时间"
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
