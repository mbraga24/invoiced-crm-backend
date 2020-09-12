Rails.application.routes.draw do
  devise_for :users
  namespace :v1, defaults: { format: :json } do
    resources :contacts
    # change it to a singleton where you don't need to pass an id to delete a record from the database
    # we're just taking the current_user for that request
    resource :sessions, only: [:create, :destroy]
  end
end
