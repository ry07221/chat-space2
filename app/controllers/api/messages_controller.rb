class Api::MessagesController < ApplicationController
  # before_action :set_group
  def index
    @group = Group.find(params[:group_id])
    @messages = @group.messages.includes(:user).where("id > ?", params[:id])
                                              # where("id > #{last_message_id}")
  end


#   private

#   def message_params
#     params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
#   end

#   def set_group
#   @group = Group.find(params[:group_id])  
#   end
end

