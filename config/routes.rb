Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'user/homes#top'

  mount ActionCable.server => '/cable'
  # userのdeviseのrouting
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  # userのrouting  module: "user"の記述でuserフォルダを指定している
  get 'about' => 'user/homes#about'
  get 'news' => 'user/homes#news'
  resources :contacts, only: [:new, :create], module: 'user'
  get 'contacts/confirm' => 'user/contacts#confirm'
  post 'contacts/edit' => 'user/contacts#edit'
  get 'contacts/thanks' => 'user/contacts#thanks'
  get 'mcs' => 'user/tops#top'
  resources :users, only: [:index, :show, :edit, :update], module: 'user' do
    member do
        get :following, :followers
    end
    resources :notices, only: [:new, :create]
  end
  resources :skills, only: [:create, :destroy], module: 'user'
  # user#showとのpathを変えるための記載
  put 'users/:id/hide' => 'user/users#hide', as: 'users_hide'
  resources :relationships, only: [:create, :destroy], module: 'user'
  get 'searches' => 'user/searches#search'
  resources :posts, only: [:index, :show, :create, :destroy], module: 'user' do
    resource :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :rooms, module: 'user'

  # adminのdeviseのrouting
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords'
    # registrations: 'admins/registrations'
  }

  # adminのrouting
  namespace :admin do
    get 'home' => 'homes#top'
    resources :notices, only: [:index, :show]
    resources :news, only: [:index, :create, :destroy]
    get 'news/confirm' => 'news#confirm'
    resources :users, only: [:index, :show, :update] do
      member do
          get :following, :followers
      end
    end
    get 'searches' => 'searches#search'
    resources :contacts, only: [:index, :show, :create, :update]
    resources :menus, only: [:index, :create, :update, :destroy]
  end

end
