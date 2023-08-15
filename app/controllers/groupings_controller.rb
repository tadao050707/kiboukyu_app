class GroupingsController < ApplicationController

  def index
    
  end

  def create
    grouping = self.user.groupings.create(group_id: params[:group_id])
    redirect_to group_path(grouping.group_id), notice: "#{grouping.user.name}さんが参加されました。"
  end

  def update
    grouping = self.user.groupings.find_by(id: params[:id]).update(leave_group: true)
    redirect_to group_path(grouping.group_id), notice: "#{grouping.user.name}さんが除名されました。"
  end

  def destroy
    user_name = self.user.name
    back_url = grouping.group_id
    grouping = self.user.groupings.find_by(id: params[:id]).destroy
    redirect_to group_path(back_url), notice: "#{user_name}さんが完全に除名されました。"
  end
end
