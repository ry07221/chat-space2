class MessagesController < ApplicationController
  before_action :set_group  #messagesコントローラの全てのアクションで@groupを利用できるようにするため

  def index
    @message = Message.new
    @messages = @group.messages.includes(:user)   #「n + 1 問題」を避けるための記述
  end

  def create
    @message = @group.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.html {redirect_to group_messages_path(@group) , notice: 'Messages sent'}
        format.json
      end
    else
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = 'Input Messages'
      render :index
    end
  end


  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
