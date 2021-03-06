class ContactsController < ApplicationController

  before_filter :initialize_contact_id, :only => [:create]


  def index
    @contacts = current_user.contacts.all
  end


  def create
  if self.contact_exists?
      flash[:alert] = "Already a contact!"
      return redirect_to :contacts
    end

    @contact = current_user.contacts.build(:contact_id => @contact_id)

    @contact.save ?
      flash[:notice] = "Added contact." :
      flash[:error] = "Unable to add contact."

    redirect_to :contacts
  end


  def destroy
    @contact = current_user.contacts.find(params[:id])
    @contact.destroy
    flash[:notice] = "Removed contact."
    redirect_to current_user
  end


  def invite
    OwerightMailer.send_contact_invitation(params[:email], current_user).deliver_now

    redirect_to :contacts, :notice => "Successfully sent an invitation to #{params[:email]}."
  end




  protected

  def initialize_contact_id
    user = User.where(:email => params[:contact_email]).first

    if user.nil?
      flash[:alert] = "User doesn't Exist!"
      return redirect_to contacts_path(:email => params[:contact_email])
    else
      @contact_id = user.id
    end
  end


  def contact_exists?
    current_user.contacts.where(:contact_id => @contact_id).any?
  end

end
