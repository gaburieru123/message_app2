class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @re_uname = @user.name
    @current_uname = User.find_by(name: current_user.name)
    @sent_messages = current_user.sent_messages.where(recipient_id: params[:id])
    @received_messages = @user.sent_messages.where(recipient_id: current_user.id)
    @messages = (@sent_messages + @received_messages).sort_by(&:created_at)
  end

  def destroy
    user = User.find(params[:id])
    if user.id == current_user.id && user.destroy
      flash[:notice] = "アカウント削除に成功しました"
      redirect_to new_user_registration_path
    else
      flash[:notice] = "無効な操作です。アカウント削除はできません。"
      redirect_to user_path
    end
  end

end
