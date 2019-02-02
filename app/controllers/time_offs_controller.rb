class TimeOffsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_time_off, only: [:show, :edit, :update, :destroy]

  # GET /time_offs
  # GET /time_offs.json
  def index
    if current_user.admin?  
      @time_offs = TimeOff.all
    else
      @time_offs = current_user.time_offs
    end
  end

  # GET /time_offs/1
  # GET /time_offs/1.json
  def show
    @time_offs = TimeOff.find(params[:id])
    unless @time_offs.user == current_user
      redirect_to time_offs_url, notice: "You're not authorized to check timeoffs of #{@atime_off.user.first_name} #{@time_off.user.last_name}."
    end
  end

  # GET /time_offs/new
  def new
    @time_off = TimeOff.new
  end

  # GET /time_offs/1/edit
  def edit
  end

  # POST /time_offs
  # POST /time_offs.json
  def create
    @time_off = TimeOff.new(time_off_params)

    respond_to do |format|
      if @time_off.save
        format.html { redirect_to @time_off, notice: 'Time off was successfully created.' }
        format.json { render :show, status: :created, location: @time_off }
      else
        format.html { render :new }
        format.json { render json: @time_off.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_offs/1
  # PATCH/PUT /time_offs/1.json
  def update
    respond_to do |format|
      if @time_off.update(time_off_params)
        format.html { redirect_to @time_off, notice: 'Time off was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_off }
      else
        format.html { render :edit }
        format.json { render json: @time_off.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_offs/1
  # DELETE /time_offs/1.json
  def destroy
    @time_off.destroy
    respond_to do |format|
      format.html { redirect_to time_offs_url, notice: 'Time off was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_off
      @time_off = TimeOff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_off_params
      params.require(:time_off).permit(:from_date, :to_date, :note).merge(user_id: current_user.id)
    end
  end

