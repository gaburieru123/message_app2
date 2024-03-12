class MessagesController < ApplicationController
  before_action :authenticate_user!, except: [:new]

  def index
  end
  
  def new
  end
  
  def create
    message = Message.new(message: params[:message], sender_id: current_user.id, recipient_id: params[:recipient_id])
      if message.save
        flash[:notice] = "メッセージ作成に成功しました"
        redirect_to "/user/#{params[:id]}"
      else
        flash[:error] = message.errors.full_messages
        render :new, status: :unprocessable_entity
      end
  end
end
