class Public::PostsController < ApplicationController
  def new
    @genres = Genre.all
    @post = Post.new
  end

  def create
    @post =Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to public_posts_path(current_customer)
    else
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page])
    @genres = Genre.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = Comment.all
    @genres = Genre.all
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :body, :genre_id, :name)
  end
end
