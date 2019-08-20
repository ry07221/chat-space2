class Api::MessagesController < ApplicationController
  # before_action :set_group
  def index
    @group = Group.find(params[:group_id])
    # ルーティングでの設定によりparamsの中にgroup_idというキーでグループのidが入るので、これを元にDBからグループを取得する
    last_message_id = params[:id].to_i
    # ajaxで送られてくる最後のメッセージのid番号を変数に代入
    
    @messages = @group.messages.includes(:user).where("id > ?", params[:last_id])
     # 取得したグループでのメッセージ達から、idがlast_messge_idよりも新しい(大きい)メッセージ達のみを取得
  end


#   private

#   def message_params
#     params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
#   end

#   def set_group
#   @group = Group.find(params[:group_id])  
#   end
end


