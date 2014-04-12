module Admin
  class BlogsController < ApplicationController

    def new
      @blog = current_user.blogs.new
    end

    def create
      blog = Blog.new blog_params
      blog.status = "drafted"
      blog.save!

      redirect_to blog_path(blog.id)
    end

    def show
      @blog = Blog.find(params[:id])
    end




    private

    def blog_params
      params.require(:blog).permit(:title, :contents,:user_id)
    end

  end
end
