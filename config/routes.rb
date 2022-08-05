Rails.application.routes.draw do
  devise_for :users
  root to: "todolists#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :todolists, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :tasks, only: [:create, :destroy] do
      resources :done_tasks, only: [:create]
    end
  end
end
