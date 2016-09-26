module API
  module Entities
    class Permission < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.try :iso8601 }
      expose :id, :documentation => {
        type: "Integer",
        desc: "user_groupID",
      }
      expose :code, :documentation => {
        type: "String",
        desc: "权限码",
      }
      expose :name, :documentation => {
        type: "String",
        desc: "名称"
      }
      expose :description, :documentation => {
        type: "String",
        desc: "描述"
      }
    end
  end
end
