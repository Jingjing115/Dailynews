module API
  class V1 < Grape::API
    format :json

    mount API::V1Users
    mount API::V1Blogs
    mount API::V1Dailies
  end
end
