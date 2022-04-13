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
    resources :posts, only:[:new, :create, :index, :show, :edit]
    post "posts/new" => "posts#new"
    post 'new', to: 'posts#new'
  end
  namespace :admin do
    resources :genres
  end
end
