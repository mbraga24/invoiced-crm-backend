# Invoiced CRM Application - Backend

### Set up CORS

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