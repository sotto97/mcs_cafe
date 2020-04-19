class Admin::ContactsController < ApplicationController
  def index
  	@contacts = Contact.all.order(created_at: :desc)
  end

  def show
  	@contact = Contact.find(params[:id])
  	# @contact_reply = Contact.new(reply_params)
  end

  def create
  end

  def update
  	@contact = Contact.find(params[:id])
  	if @contact.update(contact_params)
  		redirect_to admin_contacts_path
  	end
  end
  private
  def contact_params
    params.permit(:is_deleted)
  end
  # def reply_params
  #   params.require(:contact).permit(:body)
  # end
end
