class BlogsController < ApplicationController

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      flash[:success] = "Blog created"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    Blog.find(params[:id]).destroy
    flash[:success] = "user Deleted"
    redirect_to blogs_path
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      flash[:success] = 'Blog updated'
      redirect_to blogs_path
    else
      render "edit"
    end
  end


  def blog_params
    params.require(:blog).permit(:title, :blog)
  end

  def index
    @blogs = Blog.paginate(page: params[:page], per_page: 10)
  end

end
