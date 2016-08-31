module API
  class V1Users < Grape::API
    version 'v1', using: :header, vendor: 'huantengsmart'
    format :json
    prefix :api

    helpers do
      def op_result result
        if result.is_a? String
          error!({error: result}, 400)
        elsif result.is_a? User
          present :success, true
          present :user, result, with: API::Entities::User
        elsif result.is_a? Session
          present :success, true
          present :session, result, with: API::Entities::Session
        end
      end
    end

    resource :users do

      desc '登陆'
      params do
        requires :email, type: String, desc: '邮箱'
        requires :password, type: String, desc: '密码'
      end
      post '/login' do
        params[:user_agent] = env['HTTP_USER_AGENT'].to_s.strip[0..255]
        result = User.login params
        op_result result
      end

      desc '注册'
      params do
        requires :email, type: String, desc: '邮箱'
        requires :password, type: String, desc: '密码'
        requires :name, type: String, desc: '姓名'
      end
      post '/regist' do
        result = User.regist params
        op_result result
      end

      desc '修改密码'
      params do
        requires :email, type: String, desc: '邮箱'
        requires :password, type: String, desc: '原密码'
        requires :new_password, type: String, desc: '新密码'
      end
      put '/change_pwd' do
        result = User.change_pwd params
        op_result result
      end
    end
  end
end
