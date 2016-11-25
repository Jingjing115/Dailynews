module API
  class V1Users < Grape::API

    resource :user do
      desc '登陆'
      params do
        requires :email, type: String, desc: '邮箱'
        requires :password, type: String, desc: '密码'
      end
      post '/login' do
        params[:user_agent] = env['HTTP_USER_AGENT'].to_s.strip[0..255]
        result = User.login params
        error!({error: result}) if result.is_a? String
        present :success, true
        present :session, result, with: API::Entities::Session
      end

      desc '注册'
      params do
        requires :email, type: String, desc: '邮箱'
        requires :password, type: String, desc: '密码'
        requires :name, type: String, desc: '姓名'
      end
      post '/regist' do
        result = User.regist params
        error!({error: result}) if result.is_a? String
        present :success, true
      end

      desc '修改密码'
      params do
        requires :email, type: String, desc: '邮箱'
        requires :password, type: String, desc: '原密码'
        requires :new_password, type: String, desc: '新密码'
      end
      put '/change_pwd' do
        result = User.change_pwd params
        error!({error: result}) if result.is_a? String
        present :success, true
      end
    end
  end
end
