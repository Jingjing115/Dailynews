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
      expose :author, :documentation => {
        type: "Hash",
        desc: "发布者信息"
      } do |instance, options|
        {
          id: instance.user.id,
          name: instance.user.name
        }
      end
      expose :type, :documentation => {
        type: "String",
        desc: "评论或回复"
      } do |instance, options|
        instance.source.present? ? 'reply' : 'comment'
      end
      expose :source, :documentation => {
        type: "String",
        desc: "回复对象",
      }, if: lambda { |instance, options|
        instance.source.present?
      } do |instance, options|
        {
          id: instance.source.id,
          content: instance.source.content
        }
      end
      expose :created_at, :documentation => {
        type: "Date",
        desc: "评论时间"
      }
      expose :content, :documentation => {
        type: "Text",
        desc: "内容",
      }
    end
  end
end
