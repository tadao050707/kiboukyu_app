class GroupController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner = current_user
    if @group.save
      @group.invite_member(@group.owner)
      redirect_to @group, notice: "#{@group.name}グループに参加しました。"
    else
      flash.now[:error] = "グループ作成に失敗しました"
      render :new
    end
  end

  def show
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
end
