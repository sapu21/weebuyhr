class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]

  # GET /attendances
  # GET /attendances.json
  def index

    if current_user.admin?
      @attendances = Attendance.all
    else
      @attendances = current_user.attendances
    end

    @attendances = @attendances.order(created_at: :desc).page params[:page]

    @time_in_present = current_user.attendances.where(time_in: Date.today.all_day).present?
    @time_out_present = current_user.attendances.where(time_out: Date.today.all_day).present?

  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
    @attendance = Attendance.find(params[:id])
    unless @attendance.user == current_user
      redirect_to attendances_url, notice: "You're not authorized to check attendance of #{@attendance.user.first_name} #{@attendance.user.last_name}."
    end
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances
  # POST /attendances.json
  def create
    @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to @attendance, notice: 'Attendance was successfully created.' }
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to @attendance, notice: 'Attendance was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: 'Attendance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_comment
    @attendance = current_user.attendances.where(time_in: Date.today.all_day).last
    if @attendance.blank?
      redirect_to attendances_url, notice: "Please log you're time_in first!"
    end
  end

  def create_comment
    attendance = current_user.attendances.where(time_in: Date.today.all_day).last
    if attendance.blank?
      redirect_to attendances_url, notice: "Please log you're time_in first!"
    else
      attendance.update_attributes(time_out: DateTime.now, comments: "#{params[:comments1]}\n#{params[:comments2]}\n#{params[:comments3]}")
      redirect_to attendances_url, notice: "Thanks for your contribution! Take Rest! See you soon!"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.fetch(:attendance, {})
    end
end
