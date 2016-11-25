module API
  class V1Dailies < Grape::API
    helpers API::Helpers::Authentication

    helpers do
      def daily
        Daily.find_by(id: params[:id]) || error!({error: "daily not found"}, 404)
      end

      def my_today_daily
        current_user.dailies.find_by(id: params[:id], created_at: Time.now.to_date.beginning_of_day..Time.now.to_date.end_of_day) || error!({error: "daily not found"}, 404)
      end
    end

    before do
      error!({error: 'have no permission'}, 403) unless current_user.has_perm? :daily
    end

    resource :dailies do
      desc '获取所有daily'
      params do
        optional :per_page, type: Integer, desc: '每页容量', default: 10
        optional :page, type: Integer, desc: '页数', default: 1
        optional :key_words, type: String, desc: '搜索关键词'
        optional :release_date, type: String, desc: '发布日期精确到日 如2016-08-08 默认当天', default: ''
      end
      get do
        release_date = params[:release_date].to_date || Time.now.to_date
        if params[:key_words].blank?
          dailies = Daily.where(created_at: release_date.beginning_of_day..release_date.end_of_day)
        else
          dailies = Daily.where("content LIKE '%#{params[:key_words]}%'")
        end
        dailies = dailies.paginate(page: params[:page],per_page: params[:per_page])
        present :success, true
        present :dailies, dailies, with: API::Entities::Daily, user: current_user
      end

      desc '获取某条daily'
      params do
        requires :id, type: Integer, desc: 'dailyID'
      end
      get '/:id' do
        present :success, true
        present :daily, daily, with: API::Entities::Daily, user: current_user
      end

      desc '修改自己当天的daily'
      params do
        requires :id, type: Integer, desc: 'dailyID'
        requires :content, type: String, desc: '晨报内容'
      end
      put '/:id' do
        my_today_daily.update_attributes(content: params[:content])
        present :success, true
        present :daily my_today_daily, with: API::Entities::Daily, user: current_user
      end

      desc '写daily'
      params do
        requires :content, type: String, desc: '内容'
      end
      post do
        new_daily = current_user.dailies.find_by(id: params[:id], created_at: Time.now.to_date.beginning_of_day..Time.now.to_date.end_of_day)
        if new_daily
          new_daily.update_attributes(content: params[:content])
        else
          new_daily = Daily.create(user: current_user, content: params[:content])
        end
        present :success, true
        present :daily, new_daily, with: API::Entities::Daily, user: current_user
      end
    end
  end
end
