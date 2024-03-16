class MessagesController < ApplicationController
  before_action :authenticate_user!, except: [:new]
  before_action :correct_user, only: [:edit, :update]
  
  def new
  end
  
  def create
    message = Message.new(message: params[:message], sender_id: current_user.id, recipient_id: params[:recipient_id])
      if message.save
        flash[:notice] = "メッセージ作成に成功しました"
        redirect_to "/users/#{message.recipient_id}"
      else
        flash[:error] = message.errors.full_messages
        render :new, status: :unprocessable_entity
      end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    message = Message.find(params[:id])
    if message.update(edit_message_params)
      flash[:notice] = "メッセージ編集に成功しました"
      redirect_to "/users/#{message.recipient_id}"
    else
      flash[:error] = message.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def edit_message_params
    params.require(:message).permit(:message)
  end

  def correct_user
    msg = Message.find(params[:id])
    if user_signed_in? && msg.sender_id == current_user.id
    else 
      flash[:notice] = "無効な操作です。"
      redirect_to root_path
    end
  end

end
