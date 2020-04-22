class User::ContactsController < ApplicationController
  before_action :contact_params, only: [:confirm, :back, :create]

  def new
  	@contact = Contact.new
  end

  def confirm
   	@contact = Contact.new(contact_params)
		if @contact.valid?
			render :confirm
		else
	    render :new
		end
  end

  def back #viewで"入力画面に戻る"を押した時に使うaction
    render :new
  end

	def create
  	@contact = Contact.new(contact_params)
    if params[:back]
      render :new
		else
			@contact.save
			redirect_to contacts_thanks_path
		end
	end

  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:title, :body, :email)
  end
end