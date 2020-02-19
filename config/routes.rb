
Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'
  
  resources :users, only: [:index, :edit, :update]
  resources :groups, only: [:index, :new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]   #投稿されたメッセージの一覧表示 & メッセージの入力
    namespace :api do
      resources :messages, only: :index, defaults: { format: 'json' }
    end
  end
end


