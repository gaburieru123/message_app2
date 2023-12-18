class MessagesController < ApplicationController

  def new
    
  end
  
  def create
    @message = Message.new(message: params[:message])
    # @message.user_id = current_user.id
      if @message.save
        flash[:notice] = "タスク作成に成功しました"
        redirect_to "/"
      else
        flash[:error] = @message.errors.full_messages
        render :new, status: :unprocessable_entity
      end
  end
end
