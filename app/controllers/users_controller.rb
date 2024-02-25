class UsersController < ApplicationController
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

end
