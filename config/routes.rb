Rails.application.routes.draw do
  resources :cars do
    get 'statistics', on: :collection
    get 'actions', on: :collection
    get 'urgent_informations', on: :collection
    get 'repairs', on: :collection
    get 'search_by_model', on: :collection
    get 'before_destroy', on: :collection
    get 'add_trip', on: :collection
    resources :journeys 
    resources :car_options
    resources :repairs
  end

  devise_for :users

  delete 'users/sign_out', to: 'devise/sessions#destroy'

  devise_scope :user do
    root to: "devise/sessions#new"
  end 

  resources :users do
    resources :car_histories
  end


  get '/user' => "cars#index", :as => :user_root
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
