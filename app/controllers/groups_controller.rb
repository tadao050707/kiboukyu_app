class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner = current_user
    if @group.save
      @group.groupings.create(user: @group.owner)
      redirect_to group_path(@group), notice: "グループ『#{@group.name}』を作成しました。"
    else
      flash.now[:alert] = "グループ作成に失敗しました"
      render :new
    end
  end

  def show
    @groupings = @group.groupings.where(leave_group: false)
    @users = @groupings.map{|g| User.where(id: g.user_id)}.flatten
  end

  def edit
  end

  def update
    before_name = @group.name
    if @group.update(group_params)
      redirect_to group_path(@group), notice: "#{before_name}を編集しました"
    else
      flash.now[:alert] = "編集に失敗しました"
      render :edit
    end
  end

  def change_owner
    @group = Group.find(params[:group_id])
    before_owner = @group.owner.name
    if @group.update_attribute(:owner_id, params[:user_id])
      redirect_to @group, notice: "#{before_owner}さんから#{@group.owner.name}さんに、オーナー権限を譲渡しました"
    else
      flash.now[:alert] = "オーナー譲渡に失敗しました"
      render :show
    end
  end
  
  def destroy
  end
  
  private
  def group_params
    params.require(:group).permit(:name, :owner_id)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
