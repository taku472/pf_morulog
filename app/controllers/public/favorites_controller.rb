class Public::FavoritesController < Public::ApplicationController
  before_action :post_params

  def create
    Favorite.create(customer_id: current_customer.id, post_id: @post.id)
  end

  def destroy
    favorite = Favorite.find_by(customer_id: current_customer.id, post_id: @post.id)
    favorite.destroy
  end

  private

  def post_params
    @post = Post.find(params[:post_id])
  end

end
