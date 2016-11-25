module API
  class V1 < Grape::API

    version 'v1', using: :header, vendor: 'huantengsmart'
    format :json
    prefix :api

    mount API::V1Users
    mount API::V1Blogs
    mount API::V1Dailies
    mount API::V1Dashboard

  end
end
