class V1::ContactsController < ApplicationController
  def index
    @contacts = Contact.all

    render json: @contacts, status: :ok
  end

  def create
    # byebug
    @contact = Contact.new(contact_params)
    
    @contact.save
    render json: @contact, status: :created
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])

    # head is just a way for rails to return just the content in the header
    if @contact.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email)
  end
end
