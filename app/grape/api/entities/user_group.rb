module API
  module Entities
    class UserGroup < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.try :iso8601 }
      expose :id, :documentation => {
        type: "Integer",
        desc: "user_groupID",
      }
      expose :name, :documentation => {
        type: "String",
        desc: "名称"
      }
      expose :description, :documentation => {
        type: "String",
        desc: "描述"
      }
      expose :users, :documentation => {
        type: "Array",
        desc: "用户"
      }, with: API::Entities::User
      expose :permissions, :documentation => {
        type: "String",
        desc: "权限"
      }, with: API::Entities::Permission
    end
  end
end
