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

    rescue ActiveRecord::RecordInvalid => e
      @error = e
      render :blog_error, error: e
    end

    def show
      @blog = Blog.find(params[:id])
    end

    def destroy
      @blog = Blog.find params[:id]
      @blog.destroy!

    rescue ActiveRecord::RecordInvalid => e
      @error = e
      render :blog_error
    end

    private

    def blog_params
      params.require(:blog).permit(:title, :contents,:user_id)
    end

  end
end
