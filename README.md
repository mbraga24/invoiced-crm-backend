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
### Create sessions_controller and actions
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
## AUTHENTICATION OPTION: 1

### Add simple_token_authentication [gem](https://github.com/gonzalo-bulnes/simple_token_authentication)
_Add gem to the gem file_
```
gem 'simple_token_authentication', '~> 1.0'
```
_Run bundle in your termianl_
```
bundle install
```
### Make models token authenticatable
```
# app/models/user.rb

class User < ActiveRecord::Base
  acts_as_token_authenticatable <===== Add this line

  # Note: you can include any module you want. If available,
  # token authentication will be performed before any other
  # Devise authentication method.
  #
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  # ...
end
```
### Add the authentication_token column to the user's table
```
rails g migration add_authentication_token_to_users "authentication_token:string{30}:uniq"
```
_Run migration_
```
rake db:migrate
```
### Build create action body in sessions_controller
```
# app/controllers/v1/sessions_controller.rb
...
  def create
    user = User.find_by(email: params[:email])

    if user && user.valid_password?(params[:password])
      # return email and authentication_token on the client side
      render json: user.as_json(only: [:email, :authentication_token]), status: :created
    else
      heade(:unauthorized)
    end
  end
...
```
### Allow controllers to handle token authentication
```
# app/controllers/application_controller.rb

class ApplicationController < ActionController::API

  # When logged in this will allow to get the current user's object when the correct headers are passed in.
  acts_as_token_authentication_handler_for User, fallback: :none <===== Add this line

  # (From the docs) 
  # The token authentification handler for User watches the following headers:
  # `X-User-Token, X-User-Email`

  # By passing the email and the token as a header the simple_authentication_token gem and devise work 
  # together and return the current_user that we can use in our controllers.

end

```