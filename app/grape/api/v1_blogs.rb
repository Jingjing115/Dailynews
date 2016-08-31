module API
  class V1Blogs < Grape::API
    helpers API::Helpers::Authentication

    version 'v1', using: :header, vendor: 'huantengsmart'
    format :json
    prefix :api

    helpers do

      def blog
        Blog.find_by(id: params[:id]) || error!({error: "blog not found"}, 404)
      end

      def op_result result
        if result.is_a? String
          error!({error: result}, 400)
        elsif result.is_a? Blog
          present :success, true
          present :blog, result, with: API::Entities::Blog
        end
      end

    end

    resource :blogs do

      desc '获取所有blog'
      params do
        optional :page_size, type: Integer, desc: '每页容量', default: 10
        optional :page_num, type: Integer, desc: '页数', default: 1
      end
      get do
        blogs = Blog.all
        present :success, true
        present :blogs, blogs, with: API::Entities::Blog
      end

      desc '获取某条blog'
      params do
        requires :id, type: Integer, desc: 'blogID'
      end
      get '/:id' do
        op_result blog
      end

      desc '发布blog'
      params do
        requires :title, type: String, desc: '标题'
        requires :content, type: String, desc: '内容'
      end
      post do
        op_result Blog.create(user: current_user, title: params[:title], content: params[:content])
      end

      desc '添加评论'
      params do
        requires :id, type: Integer, desc: 'blogID'
        requires :content, type: String, desc: '内容'
      end
      post '/:id/comments' do
        blog.comments.create(user: current_user, blog: blog, content: params[:content])
        op_result blog.reload
      end
    end
  end
end
