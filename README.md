# Invoiced CRM Application - Backend

### Setting up CORS [gem](https://github.com/cyu/rack-cors)

_Go to your gem file and uncomment the following line:_
```
gem 'rack-cors'
```
_Run `bundle install`_

_Go to `cors.rb` file and paste the following code:_
```
===============================================
      config -> initializers -> cors.rb
===============================================
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

### Setting up DEVISE [gem](https://github.com/heartcombo/devise)
_Add devise gem to the gem file_
```
gem 'devise'
```
_Run bundle in your terminal_
```
bundle install
```
_Run the generator_
```
rails generate devise:install
```
_Generate the User model_
```
rails generate devise user
```
_Run migration_
```
rails db:migrate
```
### Create sessions_controller
```
class V1::SessionsController < ApplicationController

  def create
  end

  def destroy
  end

end
```
### Update routes.rb
```
  # devise_for :users ====> Because I will build a custom authentication I won't use devise default routes
  namespace :v1 do
    resources :contacts
    resources :sessions, only: [:create, :destroy] <==== Add controller and actions
  end
end
```