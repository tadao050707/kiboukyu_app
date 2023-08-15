class GroupingsController < ApplicationController
  def index
    @group = Group.find(params[:group_id]) if params[:group_id].present?
    @group = Group.find(params[:grouping][:group_id]) if params[:grouping].present?
    @user = "メールアドレスでユーザーを探しましょう。"
    if params[:grouping].present?
      @user = User.where(email: params[:grouping][:email])
    end
  end

  def create
    grouping = Grouping.find(user_id: params[:user_id]).groupings.create(group_id: params[:group_id])
    redirect_to group_path(grouping.group_id), notice: "#{grouping.user.name}さんが参加されました。"
  end

  def update
    binding.pry
    grouping = Grouping.where(user_id: params[:user_id]).where(group_id: params[:id]).includes(:user)
    grouping.update(user_id: params[:user_id], group_id: params[:group_id], leave_group: true)
    redirect_to group_path(params[:id]), notice: "#{User.find(params[:user_id]).name}さんが除名されました。"
  end

  def destroy
    grouping = Grouping.find_by(params[:id]).destroy
    redirect_to group_path(params[:id]), notice: "#{grouping.user.name}さんが完全に除名されました。"
  end

  private
  # def in_or_out(grouping)
  #   if grouping.leave_group
  #     false
  #   else
  #     true
  #   end
  # end
end
