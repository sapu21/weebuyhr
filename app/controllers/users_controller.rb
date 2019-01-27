class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = current_user
  end

  def log_time_in
    attendance = current_user.attendances.create(time_in: DateTime.now)
    redirect_to attendances_url, notice: "You've successfully started your day at Work. Rock it!"
  end

  def log_time_out
    attendance = current_user.attendances.where(time_in: Date.today.all_day).last
    if attendance.blank?
      redirect_to attendances_url, notice: "Please log you're time_in first!"
    else
      attendance.update_attributes(time_out: DateTime.now)
      redirect_to attendances_url, notice: "Thanks for your contribution! Take Rest! See you soon!"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end
end
