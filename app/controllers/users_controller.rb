class UsersController < ApplicationController
  def index
    @users = User.where('name LIKE(?)',"%#{params[:keyword]}%").where.not(id: current_user)
    respond_to do |format|
      format.json
      format.html
      
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
end
