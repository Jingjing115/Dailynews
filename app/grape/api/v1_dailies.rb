module API
  class V1Dailies < Grape::API
    helpers API::Helpers::Authentication

    version 'v1', using: :header, vendor: 'huantengsmart'
    format :json
    prefix :api

    helpers do

      def daily
        Daily.find_by(id: params[:id]) || error!({error: "daily not found"}, 404)
      end

      def my_daily
        current_user.dailies.find_by(id: params[:id]) || error!({error: "daily not found"}, 404)
      end

      def op_result result
        if result.is_a? String
          error!({error: result}, 400)
        elsif result.is_a? Daily
          present :success, true
          present :daily, result, with: API::Entities::Daily
        end
      end

    end

    # before do
    #   current_user.has_perm? :daily
    # end

    resource :dailies do

      desc '获取所有daily'
      params do
        optional :per_page, type: Integer, desc: '每页容量', default: 10
        optional :page, type: Integer, desc: '页数', default: 1
        optional :key_words, type: String, desc: '搜索关键词', default: ''
        optional :release_date, type: String, desc: '发布日期精确到日 如2016-08-08 默认当天', default: ''
      end
      get do
        release_date = params[:release_date].to_date || Time.now.to_date
        dailies = Daily.where("content LIKE '%#{params[:key_words]}%'")
        dailies = dailies.where(created_at: release_date.beginning_of_day..release_date.end_of_day) unless params[:key_words]
        dailies = dailies.paginate(page: params[:page],per_page: params[:per_page])
        present :success, true
        present :dailies, dailies, with: API::Entities::Daily
      end

      desc '获取某条daily'
      params do
        requires :id, type: Integer, desc: 'dailyID'
      end
      get '/:id' do
        op_result daily
      end

      desc '修改某条daily'
      params do
        requires :id, type: Integer, desc: 'dailyID'
        requires :content, type: String, desc: '晨报内容'
      end
      put '/:id' do
        my_daily.update_attributes(content: params[:content])
        op_result daily.reload
      end

      desc '发布daily'
      params do
        requires :content, type: String, desc: '内容'
      end
      post do
        op_result Daily.create(user: current_user, content: params[:content])
      end

    end
  end
end
