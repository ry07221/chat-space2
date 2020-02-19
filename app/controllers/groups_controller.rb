class GroupsController < ApplicationController
  before_action :set_groups, only: [:edit, :update]

  def index
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: 'Created New Group'
    else
      render :new, notice: 'Input Group name'
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to group_messages_path(@group), notice: 'Update Group'
    else
      render :edit
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, { :user_ids => [] })
  end

  def set_groups
    @group = Group.find(params[:id])
  end
end

