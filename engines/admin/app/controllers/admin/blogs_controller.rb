module Admin
  class BlogsController < ApplicationController

    def index
      @blogs = Blog.all
    end

    def new
      @blog = current_user.blogs.new
    end

    def create
      @blog = Blog.new blog_params
      @blog.status = "drafted"
      @blog.save!

      flash[:success] = "Blog successfully created."
      redirect_to admin_app.edit_blog_path(@blog.id)
    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = e.to_s
      render :new
    end

    def edit
      @blog = Blog.find(params[:id])
    end

    def update
      @blog = Blog.find(params[:id])
      @blog.assign_attributes blog_params

      @blog.status = 'published' if params[:commit] == 'Save & Publish'
      @blog.status = 'hidden' if params[:commit] == 'Save & Hide'

      @blog.save!

      logger.debug(@blog.status)
    rescue ActiveRecord::RecordInvalid => e
      @error = e
      render :blog_error
    end

    def show
      @blog = Blog.find(params[:id])
    end

    def destroy
      @blog = Blog.find params[:id]
      @blog.destroy!

    rescue ActiveRecord::RecordInvalid => e
      @error = e
      render :blog_error, error: e
    end

    private

    def blog_params
      params.require(:blog).permit(:title, :contents,:user_id, :status)
    end

  end
end
