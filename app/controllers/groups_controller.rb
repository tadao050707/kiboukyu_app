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
      flash.now[:error] = "グループ作成に失敗しました"
      render :new
    end
  end

  def show
    @user = @group.users
  end

  def edit
  end

  def update
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
