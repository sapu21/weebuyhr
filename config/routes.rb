Rails.application.routes.draw do
  resources :attendances, only: [:index, :show]
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show] do
    get 'log_time_in', on: :collection
    get 'log_time_out', on: :collection
  end
  root to: "attendances#index"
end
