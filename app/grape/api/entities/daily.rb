module API
  module Entities
    class Daily < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.try :iso8601 }
      expose :id, :documentation => {
        type: "Integer",
        desc: "dailyID",
      }
      expose :author_id, :documentation => {
        type: "Integer",
        desc: "发布者ID"
      } do |instance, options|
        instance.user.id
      end
      expose :author_name, :documentation => {
        type: "String",
        desc: "发布者姓名",
      } do |instance, options|
        instance.user.name
      end
      expose :created_at, :documentation => {
        type: "Date",
        desc: "发布时间"
      }
      expose :content, :documentation => {
        type: "Text",
        desc: "内容",
      }
    end
  end
end
