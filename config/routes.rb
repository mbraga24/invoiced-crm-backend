Rails.application.routes.draw do
  # devise_for :users => Because I will build my own authentication we won't need the devise default routes
  namespace :v1 do
    resources :contacts
    resources :sessions, only: [:create, :destroy]
  end
end
