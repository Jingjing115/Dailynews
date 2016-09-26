module API
  class V1Dashboard < Grape::API
    helpers API::Helpers::Authentication

    version 'v1', using: :header, vendor: 'huantengsmart'
    format :json
    prefix :api

    helpers do
      def user_group
        UserGroup.find_by(id: params[:id]) || error!({error: 'user group not found'}, 404)
      end

      def permission
        Permission.find_by(id: params[:id]) || error!({error: 'permission not found'}, 404)
      end
    end

    before do
      error!({error: 'have no permission'}, 403) unless current_user.has_perm? :admin
    end

    resource :user_groups do

      desc '获取所有user_group'
      get do
        present :success, true
        present :user_groups, UserGroup.all, with: API::Entities::UserGroup
      end

      desc '获取某个user_group'
      params do
        requires :id, type: Integer, desc: 'user_groupID'
      end
      get '/:id' do
        present :success, true
        present :user_group, user_group, with: API::Entities::UserGroup
      end

      desc '修改某个user_group'
      params do
        requires :id, type: Integer, desc: 'user_groupID'
        requires :name, type: String, desc: '名称'
        requires :description, type: String, desc: '描述'
      end
      put do
        user_group.update_attributes(name: params[:name], description: params[:description])
        present :success, true
        present :user_group, user_group, with: API::Entities::UserGroup
      end

      desc '添加新的user_group'
      params do
        requires :name, type: String, desc: '名称'
        requires :description, type: String, desc: '描述'
      end
      post do
        user_group = UserGroup.create(name: params[:name], description: params[:description])
        present :success, true
        present :user_group, user_group, with: API::Entities::UserGroup
      end

      desc '删除某个user_group'
      params do
        requires :id, type: Integer, desc: 'user_groupID'
      end
      delete '/:id' do
        user_group.destroy
        present :success, true
      end

      desc '添加user到user_group'
      params do
        requires :id, type: Integer, desc: 'user_groupID'
        requires :user_id, type: Integer, desc: 'userID'
      end
      put '/:id/users/:user_id' do
        user_group.users << (User.find_by(id: params[:user_id]) || error!({error: 'user not found'}, 404))
        present :success, true
        present :user_group, user_group.reload, with: API::Entities::UserGroup
      end

      desc '从user_group删除user'
      params do
        requires :id, type: Integer, desc: 'user_groupID'
        requires :user_id, type: Integer, desc: 'userID'
      end
      delete '/:id/users/:user_id' do
        user_group.users.delete(user_group.users.find_by(id: params[:user_id]) || error!({error: 'user not found'}, 404))
        present :success, true
        present :user_group, user_group.reload, with: API::Entities::UserGroup
      end

      desc '添加permission到user_group'
      params do
        requires :id, type: Integer, desc: 'user_groupID'
        requires :permission_id, type: Integer, desc: 'permissionID'
      end
      put '/:id/permissions/:permission_id' do
        user_group.users << (User.find_by(id: params[:permission_id]) || error!({error: 'permission not found'}, 404))
        present :success, true
        present :user_group, user_group.reload, with: API::Entities::UserGroup
      end

      desc '从user_group删除permission'
      params do
        requires :id, type: Integer, desc: 'user_groupID'
        requires :permission_id, type: Integer, desc: 'permissionID'
      end
      delete '/:id/permissions/:permission_id' do
        user_group.permissions.delete(user_group.permissions.find_by(id: params[:permission_id]) || error!({error: 'permission not found'}, 404))
        present :success, true
        present :user_group, user_group.reload, with: API::Entities::UserGroup
      end
    end

    resource :permissions do

      desc '获取所有permission'
      get do
        present :success, true
        present :permissions, Permission.all, with: API::Entities::Permission
      end

      desc '获取某个permission'
      params do
        requires :id, type: Integer, desc: 'permissionID'
      end
      get '/:id' do
        present :success, true
        present :permission, permission, with: API::Entities::Permission
      end

      desc '添加permission'
      params do
        requires :code, type: String, desc: '权限码'
        requires :name, type: String, desc: '名称'
        requires :description, type: String, desc: '描述'
      end
      post do
        permission = Permission.create(code: params[:code], name: params[:name], description: params[:description])
        present :success, true
        present :permission, permission, with: API::Entities::Permission
      end

      desc '修改某个permission'
      params do
        requires :id, type: Integer, desc: 'permissionID'
        requires :code, type: String, desc: '权限码'
        requires :name, type: String, desc: '名称'
        requires :description, type: String, desc: '描述'
      end
      post do
        permission.update_attributes(code: params[:code], name: params[:name], description: params[:description])
        present :success, true
        present :permission, permission.reload, with: API::Entities::Permission
      end

      desc '删除某个permission'
      params do
        requires :id, type: Integer, desc: 'user_groupID'
      end
      delete '/:id' do
        permission.destroy
        present :success, true
      end
    end
  end
end
