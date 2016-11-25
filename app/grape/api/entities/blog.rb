module API
  module Entities
    class Blog < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.try :iso8601 }
      expose :id, :documentation => {
        type: "Integer",
        desc: "blogID",
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
      expose :click_times, :documentation => {
        type: "Integer",
        desc: "点击量"
      }
      expose :created_at, :documentation => {
        type: "Date",
        desc: "发布时间"
      }
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
        desc: '评论与回复'
      }, with: API::Entities::Comment
    end
  end
end
