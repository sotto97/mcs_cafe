Rails.application.routes.draw do
  namespace :user do
    get 'notices/new'
    get 'notices/create'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'user/homes#top'

  # userのdeviseのrouting
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  # userのrouting  module: "user"の記述でuserフォルダを指定している
  get 'about' => 'user/homes#about'
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
  resources :relationships, only: [:index, :create, :destroy], module: 'user'
  put 'users/hide' => 'user/users#hide'
  get 'searches' => 'user/searches#search'
  resources :posts, only: [:index, :show, :create, :destroy], module: 'user' do
    resource :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  # チャットルームの実装はテーブルのカラム作成から着手
  resources :rooms, only: [:show, :create], module: 'user' do
    resources :messages, only: [:show, :create]
  end

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
       get 'relationship' => 'users#relationships'
    end
    get 'searches' => 'searches#search'
    # contactsの返信はcreateで合っているのか？
    resources :contacts, only: [:index, :show, :create, :update]
    resources :menus, only: [:index, :create, :update, :destroy]
  end

end
