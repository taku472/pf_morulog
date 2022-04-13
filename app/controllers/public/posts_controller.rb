class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post =Post.new(post_params)

    @post.customer_id = current_customer.id
    @post.save
    redirect_to public_post_path(@post)
  end

  def index
    @posts = Post.all

    logger.debug(@posts)
  end

  def show
  end

  def edit
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:posted_image, :title, :body)
  end
end
