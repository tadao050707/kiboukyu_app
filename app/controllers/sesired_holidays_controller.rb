class SesiredHolidaysController < ApplicationController
  def new
    @sesired_holiday = SesiredHoliday.new
    @group = Group.find(params[:group_id])
    @user = User.find(params[:user_id])
  end

  def create
    @sesired_holiday = User.find(params[:user_id]).sesired_holidays.new(sesired_holiday_params)
    if @sesired_holiday.save
      @grouping = Grouping.find_by(user_id: params[:user_id], group_id: params[:group_id])
      redirect_to grouping_path(@grouping), notice: "『#{@sesired_holiday.my_holiday}』で希望休申請しました。"
    else
      flash.now[:alert] = "申請に失敗しました"
      render :new
    end
  end

  def destroy
  end

  private
  def sesired_holiday_params
    params.require(:sesired_holiday).permit(:user_id, :group_id, :my_holiday)
  end
end
