class Grouping < ApplicationRecord
  belongs_to :user
  belongs_to :group

  before_update :owner_can_not_delete

  private
  def owner_can_not_delete
    if Group.find(params[:id]).owner == Grouping.find_by(user_id: params[:user_id], group_id: params[:id]).user
      throw(:about)
      flash.now[:error] = "オーナーは脱退できません"
    end
  end
end
