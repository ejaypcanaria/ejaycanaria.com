module Admin
  class BlogsController < ApplicationController

    def index
      @blogs = Blog.all
    end

    def new
      @blog = current_user.blogs.new
    end

    def create
      blog = Blog.new blog_params
      blog.status = "drafted"
      blog.save!

    rescue
      render :create_error
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
