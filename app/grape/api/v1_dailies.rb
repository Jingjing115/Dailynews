module API
  class V1Dailies < Grape::API
    helpers API::Helpers::Authentication

    helpers do
      def backwards_time
        6.hours
      end

      def time_range
        begin
          date = params[:release_date].to_date || default_date
        rescue
          date = default_date
        end
        (date.beginning_of_day + backwards_time)..(date.end_of_day + backwards_time)
      end

      def default_date
        (Time.now - backwards_time).to_date
      end

      def dailies
        Daily.where(created_at: time_range)
      end

      def daily
        Daily.find_by(id: params[:id]) || error!({errors: "daily not found"}, 404)
      end

      def my_today_daily
        current_user.dailies.where(created_at: time_range).first
      end
    end

    before do
      error!({errors: 'have no permission'}, 403) unless current_user.has_perm? :daily
    end

    resource :dailies do
      desc '获取所有daily'
      params do
        optional :per_page, type: Integer, desc: '每页容量', default: 10
        optional :page, type: Integer, desc: '页数', default: 1
        optional :release_date, type: String, desc: '发布日期精确到日 如2016-08-08 默认当天 如果格式不正确默认为当天'
      end
      get do
        present :success, true
        present :dailies, dailies.paginate(page: params[:page],per_page: params[:per_page]), with: API::Entities::Daily, user: current_user
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
        requires :title, type: String, desc: '标题'
        requires :content, type: String, desc: '晨报内容'
      end
      put '/own' do
        mtd = my_today_daily || error!({errors: 'daily not found'}, 404)
        mtd.update_attributes(title: params[:title], content: params[:content])
        present :success, true
        present :daily, mtd, with: API::Entities::Daily, user: current_user
      end

      desc '写daily'
      params do
        requires :title, type: String ,desc: '标题'
        requires :content, type: String, desc: '内容'
      end
      post do
        new_daily = my_today_daily
        if new_daily
          new_daily.update_attributes(title: params[:title], content: params[:content])
        else
          new_daily = Daily.create(user: current_user,title: params[:title], content: params[:content])
        end
        present :success, true
        present :daily, new_daily, with: API::Entities::Daily, user: current_user
      end

      desc '添加评论'
      params do

      end
      post ':id/comments' do

      end

      desc '点赞'
      params do
        requires :id, type: Integer, desc: 'daily ID'
      end
      post ':id/praise' do

      end
    end
  end
end
