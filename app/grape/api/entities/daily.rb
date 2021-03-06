module API
  module Entities
    class Daily < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.try :iso8601 }
      expose :id, :documentation => {
        type: "Integer",
        desc: "dailyID",
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
      expose :own, :documentation => {
        type: "Boolean",
        desc: "是不是自己的晨报",
      } do |instance, options|
        options[:user] == instance.user
      end
      expose :today, :documentation => {
        type: "Boolean",
        desc: "是不是当天的晨报"
      } do |instance, options|
        instance.created_at.to_date == Time.now.to_date
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
