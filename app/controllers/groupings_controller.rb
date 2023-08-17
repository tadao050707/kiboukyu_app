class GroupingsController < ApplicationController
  def index
    @group = Group.find(params[:group_id]) if params[:group_id].present?
    @user = "メールアドレスでユーザーを探しましょう。"
    if params[:grouping].present?
      @group = Group.find(params[:grouping][:group_id])
      @user = User.find_by(email: params[:grouping][:email])
      @grouping = Grouping.find_by(user_id: @user.id, group_id: @group.id)
    end
  end

  def create
    grouping = Grouping.create(user_id: params[:user_id], group_id: params[:group_id])
    redirect_to group_path(grouping.group_id), notice: "#{grouping.user.name}さんが参加されました。"
  end

  def show
    @grouping = Grouping.find(params[:id])
    @group = Group.find(@grouping.group_id)
    @user = User.find(@grouping.user_id)
    @sesired_holidays = @user.sesired_holidays.where(user_id: @user.id, group_id: @grouping.group_id)
  end
  
  def update
    if params[:id].present? && params[:user_id].present?
      grouping = Grouping.find_by(user_id: params[:user_id], group_id: params[:id])
      in_or_out(grouping)
      redirect_to group_path(params[:id]), notice: owner_or_people(grouping)
    elsif params[:id].present?
      grouping = Grouping.find(params[:id])
      in_or_out(grouping)
      redirect_to group_path(grouping.group_id), notice: "#{User.find(grouping.user_id).name}さんが再招待されました。"
    else
      flash[:alert] = "ユーザーはグループに所属していません。"
      redirect_to group_path(params[:id])
    end
  end

  def destroy
    grouping = Grouping.find_by(params[:id]).destroy
    redirect_to group_path(params[:id]), notice: "#{grouping.user.name}さんが完全に除名されました。"
  end

  private
  def in_or_out(grouping)
    new_leave_group = !grouping.leave_group
    if new_leave_group
      grouping.update_attribute(:leave_group, new_leave_group)
    else
      grouping.update(leave_group: new_leave_group)
    end
  end

  def owner_or_people(grouping)
    if grouping.group.owner == grouping.user
      "オーナーは脱退できません！" 
    else
      "#{User.find(params[:user_id]).name}さんが除名されました。"
    end
  end
end
