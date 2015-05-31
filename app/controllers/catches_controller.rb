class CatchesController < ApplicationController
  before_action :authorize_catch, except: [:index, :show]
  before_action :check_catch_params, only: [:new, :create]
  before_action :set_catch, only: [:show, :edit, :update, :destroy]
  before_action :set_competition, only: [:create]

  # GET /catches
  # GET /catches.json
  def index
    @catches = Catch.all
  end

  # GET /catches/1
  # GET /catches/1.json
  def show
  end

  # GET /catches/new
  def new
    @client_data[:species] = Species.all
    @catch = Catch.new
    competitions = current_user.competitions.active

    if competitions.count == 1
      @catch.competition = competitions.first
    end
  end

  # GET /catches/1/edit
  def edit
  end

  # POST /catches
  # POST /catches.json
  def create
    @catch = Catch.new
    @catch.competition = @competition
    @catch.user = current_user

    # We must check if the request came from a controller that wasn't Catches
    if catch_params.count == 1
      respond_to do |format|
        format.html { render :new }
      end
      return
    end

    @catch.species = catch_params[:species]
    @catch.bait_used = catch_params[:bait_used]
    @catch.length_in_inches = catch_params[:length_in_inches]
    @catch.location_description = catch_params[:location_description]
    @catch.caught_at = Date.parse catch_params[:caught_at]

    respond_to do |format|
      if @catch.save
        format.html { redirect_to @catch, notice: 'Catch was successfully created.' }
        format.json { render :show, status: :created, location: @catch }
      else
        format.html { render :new }
        format.json do
          render 'shared/error',
                 locals: { errors: @catch.errors },
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /catches/1
  # PATCH/PUT /catches/1.json
  def update
    respond_to do |format|
      if @catch.update(catch_params)
        format.html { redirect_to @catch, notice: 'Catch was successfully updated.' }
        format.json { render :show, status: :ok, location: @catch }
      else
        format.html { render :edit }
        format.json do
          render 'shared/error',
                 locals: { errors: @catch.errors },
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /catches/1
  # DELETE /catches/1.json
  def destroy
    @catch.destroy
    respond_to do |format|
      format.html { redirect_to catches_url, notice: 'Catch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # If the user is competing in multiple competitions, make sure he has indicated
  # which competition this catch is for.
  def check_catch_params
    return if catch_params.present?
    return if current_user.competitions.active.count == 1
    redirect_to request.referrer,
                notice: 'Select a competition BEFORE adding a catch. If no competitions exist yet, add one, then add a catch.'
  end

  def authorize_catch
    authorize :catch
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def catch_params
    params[:catch]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_catch
    @catch = Catch.find_by_id params[:id]
  end

  def set_competition
    @competition = Competition.find_by_id catch_params[:competition]
  end
end
