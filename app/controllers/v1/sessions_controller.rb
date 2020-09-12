class V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])

    if user && user.valid_password?(params[:password])
      # render json: user, status: :created
      render json: user.as_json(only: [:email, :authentication_token]), status: :created
    else
      heade(:unauthorized)
    end
  end

  def destroy
    current_user && current_user.authentication_token = nil

    if current_user.save 
      head(:ok)
    else
      head(:unauthorized)
    end
  end

end