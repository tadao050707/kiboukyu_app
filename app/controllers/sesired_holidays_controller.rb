class SesiredHolidaysController < ApplicationController
  before_action :sesired_holiday_current_user_or_admin, only: %i[new create destroy]
  
  def new
    @sesired_holiday = SesiredHoliday.new
    @group = Group.find(params[:group_id])
  end

  def create
    @sesired_holiday = User.find(params[:sesired_holiday][:user_id]).sesired_holidays.new(sesired_holiday_params)
    if @sesired_holiday.save
      @grouping = Grouping.find_by(user_id: params[:sesired_holiday][:user_id], group_id: params[:sesired_holiday][:group_id])
      redirect_to grouping_path(@grouping), notice: "『#{@sesired_holiday.my_holiday}』で希望休申請しました。"
    else
      flash.now[:alert] = "申請に失敗しました"
      render :new
    end
  end

  def destroy
    @sesired_holiday = SesiredHoliday.find(params[:id])
    flash[:notice] = "#{@sesired_holiday.my_holiday}の希望休が取り消されました"
    redirect_to grouping_path(params[:grouping_id])
  end

  private
  def sesired_holiday_params
    params.require(:sesired_holiday).permit(:user_id, :group_id, :my_holiday)
  end

  def sesired_holiday_current_user_or_admin
    @user = User.find(params[:id]) if params[:id].present?
    @user = User.find(params[:user_id]) if params[:user_id].present?
    @user = User.find(params[:sesired_holiday][:user_id]) if params[:sesired_holiday].present?
    binding.pry
    redirect_to user_path(current_user), notice: "他のユーザーの希望休は申請出来ません" unless current_user == @user || current_user.admin
  end
end
