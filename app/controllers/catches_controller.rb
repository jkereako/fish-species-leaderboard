class CatchesController < ApplicationController
  before_action :authorize_catch, except: [:index, :show]
  before_action :check_catch_params, only: [:new, :create]
  before_action :set_catch, only: [:show, :edit, :update, :destroy]
  before_action :set_competition, only: [:new, :create]

  # GET /catches
  # GET /catches.json
  def index
    @catches = Catch.all.recent
  end

  # GET /catches/1
  # GET /catches/1.json
  def show
  end

  # GET /catches/new
  def new
    @client_data[:species] = Species.all
    @catch = Catch.new
    @catch.competition = @competition
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
    @catch.image = catch_params[:image]
    @catch.bait_used = catch_params[:bait_used]
    @catch.length_in_inches = catch_params[:length_in_inches]
    @catch.location_description = catch_params[:location_description]
    @catch.caught_at = Date.parse catch_params[:caught_at]

    respond_to do |format|
      if @catch.save
        format.html do
          redirect_to @catch,
                      notice: 'Catch was successfully created.'
        end
        format.json do
          render :show,
                 locals: { a_catch: @catch,
                           notice: "Successfully recorded #{@catch.species}" },
                 status: :created,
                 location: @catch
        end
      else
        format.html { render :new }
        format.json do
          render 'shared/error',
                 locals: { errors: @catch.errors,
                           notice: 'Data missing or invalid' },
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
        format.html do
          redirect_to @catch,
                      notice: 'Catch was successfully updated.'
        end
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
      format.html do
        redirect_to catches_url,
                    notice: 'Catch was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # If the user is competing in multiple competitions, make sure he has indicated
  # which competition this catch is for.
  def check_catch_params
    return if current_user.competitions.active.count == 1
    # REVIEW: This will raise an exception. Figure out the best way to handle it
    return if catch_params.present?
    redirect_to :back,
                alert: 'Select a competition BEFORE adding a catch. If no competitions exist yet, add one, then add a catch.'
  end

  def authorize_catch
    authorize :catch
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def catch_params
    params[:catch]
    # params.require(:catch).permit(:species, :image, :bait_used,
    #                               :length_in_inches, :image, :location_description,
    #                               :caught_at, :competition)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_catch
    @catch = Catch.find_by_id params[:id]
  end

  def set_competition
    # First, check if the user is competing in multiple competitions
    competitions = current_user.competitions.active

    if competitions.count == 1
      @competition = competitions.first
    else
      if catch_params[:competition].present?
        @competition = Competition.find_by_id catch_params[:competition]
      end
    end
  end
end
