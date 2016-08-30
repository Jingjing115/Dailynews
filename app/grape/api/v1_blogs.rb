module API
  class V1Blogs < Grape::API

    helpers do

      def blog
        Blog.find_by(:id params[:id]) || error!({error: "blog not found"}, 404)
      end

    end

    resource :blogs do

      desc '获取所有blog'
      params do
        requires :page_size, type: Integer, desc: '每页容量', default: 10
        requires :page_num, type: Integer, desc: '页数', default: 1
      end
      get do
        blogs = Blog.where("")
        present :success, true
        present :blogs, blogs
      end

      desc '获取某条blog'
      params do
        requires :id, type: Integer, desc: 'blogID'
      end
      get '/:id' do
        present :success, true
        present :blog, blog
      end

      desc '添加评论'
      params do
        requires :id, type: Integer, desc: 'blogID'
        requires :content, type: String, desc: '内容'
      end
      post '/:id/comments' do
        Comments.create(user: current_user, blog: blog, content: params[:content])
        present :success, true
        present :blog, blog.reload
      end
    end
  end
end
