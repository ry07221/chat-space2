class UsersController < ApplicationController
  def index
  # @users = User.where('name LIKE(?)',"%#{params[:keyword]}%").where.not(id: current_user)
    @users = User.where('name LIKE(?) and id NOT IN (?)', "%#{params[:keyword]}%", excluded_users)     
    #「id NOT IN (?)」:指定した要素を含んでいないレコードを取得する
    #(?)の部分には、where文の第３引数が代入される→今回はexcluded_users
    
    respond_to do |format|
      format.json
    end
  end

  def edit  #必要になるインスタンス変数はない
  end

  def update   #保存をできた場合、できなかった場合で処理を分岐
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end



  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

  def excluded_users      # current_userと選択中のuserを表示させないためのメソッド
    excluded_users = []
    excluded_users << current_user.id

    if params[:userlist]      #グループに追加するユーザーを選択中の場合のみ発火
      params[:userlist].map do |user_id|     #userlistに代入されているuserのidを、mapメソッドを使ってinteger型に変換
        excluded_users << user_id.to_i       #userlistの値を数値に変換
      end
    end
    return excluded_users
  end


end
