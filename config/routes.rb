Rails.application.routes.draw do

  #Top
  root "public/homes#top"

  #管理者側
  devise_for :admin, skip: [:passwords], controllers: {
    sessions: "admin/sessions"
  }

  #顧客側
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #public
  namespace :public do
    get "customers/unsubscribe" => "customers#unsubscribe", as: 'unsubscribe'
    patch "customers/withdraw" => "customers#withdraw", as: 'withdraw'
    delete "posts/all_destroy" => "posts#all_destroy", as: 'all_destroy'
    resources :posts, only:[:new, :create, :index, :show, :destroy] do
      resource :favorites, only:[:create, :destroy]
      resources :comments, only:[:create, :destroy]
    end
  end

  #public
  scope module: :public do
    resources :customers, only: [:index, :show, :edit, :update]
  end

  #admin
  namespace :admin do
    resources :posts
    resources :genres
    resources :customers
  end
end
