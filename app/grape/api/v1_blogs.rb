module API
  class V1Blogs < Grape::API
    helpers API::Helpers::Authentication
    helpers do
      def blog
        Blog.find_by(id: params[:id]) || error!({error: "blog not found"}, 404)
      end

      def comment
        Comment.find_by(id: params[:id]) || error!({error: "comment not found"}, 404)
      end
    end

    resource :blogs do
      desc '获取所有blog'
      params do
        optional :per_page, type: Integer, desc: '每页容量', default: 10, values: 10..20
        optional :page, type: Integer, desc: '页数', default: 1
        optional :key_words, type: String, desc: '搜索关键词', default: ''
        optional :release_date, type: String, desc: '发布日期精确到日 如2016-08-08', default: ''
      end
      get do
        release_date = params[:release_date].to_date || Time.now.to_date
        blogs = Blog.where("title LIKE '%#{params[:key_words]}%' or content LIKE '%#{params[:key_words]}%'")
        blogs = blogs.where(created_at: release_date.beginning_of_day..release_date.end_of_day) unless params[:key_words]
        blogs = blogs.paginate(page: params[:page],per_page: params[:per_page])
        present :success, true
        present :blogs, blogs, with: API::Entities::Blog
        present :current_page, params[:page]
        present :page_count, ((blogs.count - 1) / params[:per_page]) + 1
        present :page_size, params[:per_page]
      end

      desc '获取某条blog'
      params do
        requires :id, type: Integer, desc: 'blogID'
      end
      get '/:id' do
        blog.update_attributes(click_times: blog.click_times + 1)
        present :success, true
        present :blog, blog, with: API::Entities::Blog
      end

      desc '发布blog'
      params do
        requires :title, type: String, desc: '标题'
        requires :content, type: String, desc: '内容'
      end
      post do
        present :success, true
        present :blog, Blog.create(user: current_user, title: params[:title], content: params[:content]), with: API::Entities::Blog
      end

      desc '添加评论'
      params do
        requires :id, type: Integer, desc: 'blogID'
        requires :content, type: String, desc: '评论内容'
      end
      post '/:id/comments' do
        comment = blog.comments.create(user: current_user, blog: blog, content: params[:content])
        present :success,true
        present :comment, comment, with: API::Entities::Comment
      end
    end

    resource :comments do
      desc '回复评论'
      params do
        requires :id, type: Integer, desc: 'commentID'
        requires :content, type: String, desc: '回复内容'
      end
      post '/:id/replys' do
        reply = comment.replys.create(user: current_user, blog: comment.blog, content: params[:content])
        present :success,true
        present :reply, reply, with: API::Entities::Comment
      end
    end
  end
end
