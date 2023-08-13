class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @group = groups_name(@user)
  end

  private
  def groups_name(user)
    if Grouping.where(user_id: user.id).where(leave_group: false).present?
      Group.select(:id, :name)
    else
      nil
    end
  end
end
