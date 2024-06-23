class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end

#   def index
#    @users = User.where(deleted_at: nil)
# end
  

def create
 binding.b
  self.resource = warden.authenticate!(auth_options)
  if resource.deleted_at.nil?
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  else
    flash.now[:alert] = "アカウントは無効ですよー。"
    redirect_to new_user_session_path
  end
end


  def show
    @user = User.find(params[:id])
    sent_messages = current_user.sent_messages.where(recipient_id: params[:id])
    received_messages = @user.sent_messages.where(recipient_id: current_user.id)
    if current_user.id == @user.id
      @messages = sent_messages
    elsif
      @messages = (sent_messages + received_messages).sort_by(&:created_at)
    end
  end

  # def destroy
  #   user = User.find(params[:id])
  #   if user.id == current_user.id && user.destroy
  #     flash[:notice] = "アカウント削除に成功しました"
  #     redirect_to new_user_registration_path
  #   else
  #     flash[:notice] = "無効な操作です。アカウント削除はできません。"
  #     redirect_to user_path
  #   end
  # end

  # def destroy
  #  user = User.find(params[:id])
  #   if user.id == current_user.id && user.update(deleted_at: Time.now)
  #     flash[:notice] = "アカウント削除に成功しました"
  #     redirect_to root_path
  #   else
  #     flash[:notice] = "無効な操作です。アカウント削除はできません。"
  #     redirect_to user_path
  #   end
  # end

  def update
   user = User.find(params[:id])
   # user = User.where.not(deleted_at: nil).where(id: params[:id]).first
   # or
   # binding.b
   # user = User.where.not(deleted_at: nil).find_by(id: params[:id])
    if user.id == current_user.id && user.update(deleted_at: Time.now)
      sign_out(:user)
      flash[:notice] = "アカウント削除に成功しました"
      redirect_to root_path
    else
      flash[:notice] = "無効な操作です。アカウント削除はできません。"
      redirect_to user_path
    end
  end

end
